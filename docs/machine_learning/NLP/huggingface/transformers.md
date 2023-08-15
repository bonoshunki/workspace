# Transformers

HuggingFace の transformers について備忘録

## attention_mask

input_ids のどこに注目するかを 2 値で表したもの。1 が注目する、0 が埋め込みを表す。

## Tokenizer の Tips

### 特殊トークンを取得する

```python
# Tokenの一覧
tokenizer.all_special_tokens

# TokenのIDの一覧
tokenizer.all_special_ids
```

### return_tensors

`return_tensors` とは返り値のテンソルの形式を指定するパラメータ。`pt`は pytorch、`tf`は tensorflow を指す。

### 特殊トークンを拡張する（通常トークンも同じ）

以下のコードで拡張できる。

```python
# Tokenizerの取得、よしなに変更
tokenizer = AutoTokenizer.from_pretrained(path, **tokenizer_kwargs)

# 特殊トークンを拡張する
additional_special_tokens = {'additional_special_tokens': ["A", "B"]}
tokenizer.add_special_tokens(additional_special_tokens)

# 通常トークンを拡張する
additional_tokens = ["C", "D"]
tokenizer.add_tokens(additional_tokens)
```

`additional_special_tokens`という名前出ないとエラーが出る。特殊トークンは名前が決まっており、追加トークンは`additional_special_tokens`という名前で登録することになっている。

また、追加した後は以下のコードを実行する

```python
model.resize_token_embeddings(len(tokenizer))
```

これは、model の Embedding と Output を追加したトークン分拡張してくれる。これをしないと追加したトークンを入力した時に、Tokerizer では追加した ID に Tokenize されるが、Model では認識できないためエラーとなるので注意。

また Model を拡張する場合は順番に注意。特に Input、Output を自分で拡張した場合、Resize してからでないとエラーになる（1 敗）。

## generate について

generate について少しだけ中を見る. 基本的に sample(top-k, top-p)想定.

processor と wraper で候補を絞る.

- processor
  - 省く
    - ignore するやつとか
- wraper
  - 選択する
    - temparature
    - top_k
    - top_p
- 両方とも実態は`LogitsProcessorList`

<details>
<summary>(processor, wraperの取得部分)</summary>

```python
logits_processor = self._get_logits_processor(
    generation_config=generation_config,
    input_ids_seq_length=input_ids_seq_length,
    encoder_input_ids=inputs_tensor,
    prefix_allowed_tokens_fn=prefix_allowed_tokens_fn,
    logits_processor=logits_processor,
)
logits_warper = self._get_logits_warper(generation_config)
```

</details>

`LogitsProcessorList`の中身は以下

- input_ids, scores を元に計算する
- 複数の基準がある場合、順番に適応する(積集合)

```python
class LogitsProcessorList(list):
    """
    This class can be used to create a list of [`LogitsProcessor`] or [`LogitsWarper`] to subsequently process a
    `scores` input tensor. This class inherits from list and adds a specific *__call__* method to apply each
    [`LogitsProcessor`] or [`LogitsWarper`] to the inputs.
    """

    @add_start_docstrings(LOGITS_PROCESSOR_INPUTS_DOCSTRING)
    def __call__(self, input_ids: torch.LongTensor, scores: torch.FloatTensor, **kwargs) -> torch.FloatTensor:
        for processor in self:
            function_args = inspect.signature(processor.__call__).parameters
            if len(function_args) > 2:
                if not all(arg in kwargs for arg in list(function_args.keys())[2:]):
                    raise ValueError(
                        f"Make sure that all the required parameters: {list(function_args.keys())} for "
                        f"{processor.__class__} are passed to the logits processor."
                    )
                scores = processor(input_ids, scores, **kwargs)
            else:
                scores = processor(input_ids, scores)
        return scores
```

以下が sampling で主に使いそうなパラメータ

- temparature
  - default 1
- top_p
  - default 1
- top_k
  - default 50

以下が各パラメータに対応した wraper 内の各 call 部分

```python
# temparature
def __call__(self, input_ids: torch.Tensor, scores: torch.Tensor) -> torch.FloatTensor:
    scores = scores / self.temperature
    return scores

# top-p
def __call__(self, input_ids: torch.LongTensor, scores: torch.FloatTensor) -> torch.FloatTensor:
    sorted_logits, sorted_indices = torch.sort(scores, descending=False)
    cumulative_probs = sorted_logits.softmax(dim=-1).cumsum(dim=-1)

    # Remove tokens with cumulative top_p above the threshold (token with 0 are kept)
    sorted_indices_to_remove = cumulative_probs <= (1 - self.top_p)
    if self.min_tokens_to_keep > 1:
        # Keep at least min_tokens_to_keep
        sorted_indices_to_remove[..., -self.min_tokens_to_keep :] = 0

    # scatter sorted tensors to original indexing
    indices_to_remove = sorted_indices_to_remove.scatter(1, sorted_indices, sorted_indices_to_remove)
    scores = scores.masked_fill(indices_to_remove, self.filter_value)
    return scores

# top-k
def __call__(self, input_ids: torch.LongTensor, scores: torch.FloatTensor) -> torch.FloatTensor:
    top_k = min(self.top_k, scores.size(-1))  # Safety check
    # Remove all tokens with a probability less than the last token of the top-k
    indices_to_remove = scores < torch.topk(scores, top_k)[0][..., -1, None]
    scores = scores.masked_fill(indices_to_remove, self.filter_value)
    return scores
```

sample で実際に生成する部分はこれ. 変数は以下の対応関係.

- processor -> logits_processor
- wraper -> logits_warper

```python
next_token_logits = outputs.logits[:, -1, :]
next_token_scores = logits_processor(input_ids, next_token_logits)
next_token_scores = logits_warper(input_ids, next_token_scores)
```

## よくあるエラー

多分一回は見るやつ.

```
RuntimeError: Expected all tensors to be on the same device, but found at least two devices, cuda:6 and cuda:0! (when checking argument for argument mat2 in method wrapper_CUDA_mm
```

演算の時に同じ GPU 上にデータがないのが問題でエラーになっている. 以下の 3 つを試したら大体治る.

### そもそも device に渡していない場合(cuda と cpu が出てしまう)

```python
model.to(device)
data.to(device)

model.generate(data)
```

### device_map="auto"の場合

```python
model = transformers.AutoModelForCausalLM.from_pretrained(
    model_name,
    device_map="auto",
)
model.model_parallel = True

# 消す
# model.to(device)
```

device を明示して渡すことで, せっかく`device_map="auto"`で分散していたのにわけわからんことになるんだと思う.

### device_map="sequential"の場合

```python
model = transformers.AutoModelForCausalLM.from_pretrained(
    model_name,
    device_map="sequential",
)
model.model_parallel = False

# 消す
# model.to(device)
```

これは最終手段. 多分環境によってはどうやっても分散できない場合があるので, その時は`sequential`にする. のりきるなら一つの GPU にのせてくれる.

[参考](https://huggingface.co/docs/accelerate/usage_guides/big_modeling#loading-weights)

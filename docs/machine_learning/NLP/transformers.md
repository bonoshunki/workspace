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

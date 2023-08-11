# QLoRA

- 4-bit quantized pretrained language model
- 論文
  - https://arxiv.org/pdf/2305.14314.pdf
- 公式
  - https://github.com/artidoro/qlora

## Getting Started

```
$ git clone https://github.com/artidoro/qlora.git
$ cd qlora
$ pip install -U -r requirements.txt
```

`scripts/finetune.sh`の中身みたら大体パラメータ書いてある.

## MPT-7b を使いたい

```
--learning_rate 0.000005 \
--model_name_or_path cekal/mpt-7b-peft-compatible \
--trust_remote_code True \
```

[参考](https://github.com/artidoro/qlora/issues/10#issuecomment-1565647871)

## bit 数を変える

```
# 4bit量子化
--bits 4

# 8bit量子化
--bits 8
```

## epoch で指定する

scripts 等を見ても全て max_steps で指定されている. epochs で指定したい場合は以下.

```
--max_steps -1 \
--num_train_epochs 3 \
```

デフォルトの`num_train_epochs`は 3.

## MPT-7b で学習する際のエラー

### エラーメッセージ

```
ValueError: Tokenizer class GPTNeoXTokenizer does not exist or is not currently imported.
```

GPTNeoXTokenizer は FastTokenizer しか対応していないことが原因.

### 解決策

`use_fast=True`に変更

```python
tokenizer = AutoTokenizer.from_pretrained(
    args.model_name_or_path,
    cache_dir=args.cache_dir,
    padding_side="right",
    use_fast=True,
    tokenizer_type='llama' if 'llama' in args.model_name_or_path else None, # Needed for HF name change
    trust_remote_code=args.trust_remote_code,
    use_auth_token=args.use_auth_token,
)
```

## dataset の指定

ローカルデータセットの場合は基本以下.

```
--dataset $DATASET_NAME \
--dataset_format input-output \
```

データセットの中身は以下参照.

### ファイル形式

`json`, `csv`, `tsv`がサポートされている.

<details>
<summary>ソースコード</summary>

```python
if dataset_name.endswith('.json') or dataset_name.endswith('.jsonl'):
    full_dataset = Dataset.from_json(path_or_paths=dataset_name)
elif dataset_name.endswith('.csv'):
    full_dataset = Dataset.from_pandas(pd.read_csv(dataset_name))
elif dataset_name.endswith('.tsv'):
    full_dataset = Dataset.from_pandas(pd.read_csv(dataset_name, delimiter='\t'))
else:
    raise ValueError(f"Unsupported dataset format: {dataset_name}")
```

</details>

### ファイルのフォーマット

`alpaca`, `chip2`, `self-instruct`, `hh-rlhf`, `oasst1`, `input-output`が存在する. ローカルデータセットを使う場合は`input-output`でいいと思う.

最終的に`input: ~~~, output: ~~~`のみ使用する.

<details>
<summary>ソースコード</summary>

```python
def format_dataset(dataset, dataset_format):
    if (
        dataset_format == 'alpaca' or dataset_format == 'alpaca-clean' or
        (dataset_format is None and args.dataset in ['alpaca', 'alpaca-clean'])
    ):
        dataset = dataset.map(extract_alpaca_dataset, remove_columns=['instruction'])
    elif dataset_format == 'chip2' or (dataset_format is None and args.dataset == 'chip2'):
        dataset = dataset.map(lambda x: {
            'input': x['text'].split('\n<bot>: ')[0].replace('<human>: ', ''),
            'output': x['text'].split('\n<bot>: ')[1],
        })
    elif dataset_format == 'self-instruct' or (dataset_format is None and args.dataset == 'self-instruct'):
        for old, new in [["prompt", "input"], ["completion", "output"]]:
            dataset = dataset.rename_column(old, new)
    elif dataset_format == 'hh-rlhf' or (dataset_format is None and args.dataset == 'hh-rlhf'):
        dataset = dataset.map(lambda x: {
            'input': '',
            'output': x['chosen']
        })
    elif dataset_format == 'oasst1' or (dataset_format is None and args.dataset == 'oasst1'):
        dataset = dataset.map(lambda x: {
            'input': '',
            'output': x['text'],
        })
    elif dataset_format == 'input-output':
        # leave as is
        pass
    # Remove unused columns.
    dataset = dataset.remove_columns(
        [col for col in dataset.column_names['train'] if col not in ['input', 'output']]
    )
    return dataset
```

</details>

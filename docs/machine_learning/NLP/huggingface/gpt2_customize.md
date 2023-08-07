# GPT2 の編集

GPT2 をわりかし編集して出力をいじる場合の備忘録。

## 前提

- GPT2 のモデルは、[huggingface](https://huggingface.co/)の[rinna の japanese-gpt2-small](https://huggingface.co/rinna/japanese-gpt2-small)を利用します。
- Fine tuning には、同じく[huggingface](https://huggingface.co/)が提供してくれている run_clm.py を用います。
- pytorch を使用します。

```python
import pandas as pd
import torch

from transformers import AutoModelForCausalLM, AutoTokenizer
```

## 概要

今回やりたいことは、入力から複数種類の出力を得ることです。詳しい内容は省きますが、完全に性質の違う出力を複数種類得ることを目標にします。

また、Fine Tuning は教師ありで行います。

## 複数種類出力できるように変更する。

基本的な生成の流れは以下。

```python
"""
Parameters
----------
input_text: 入力のテキスト
model: huggingfaceのモデル
tokenizer: モデルで使用されているtokenizer
"""

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

model = AutoModelForCausalLM.from_pretrained("rinna/japanese-gpt2-small")
model.to(device)

tokenizer = AutoTokenizer.from_pretrained("rinna/japanese-gpt2-small")

input_ids = tokenizer.encode(input_text, return_tensors='pt').to(device)
out = model.generate(
    input_ids,
    num_return_sequences=1,
    max_length=512,
    do_sample=True,
    temperature=1.5,
    top_p=0.95,
    top_k=40,
    bad_words_ids=[
        [tokenizer.unk_token_id],
        [tokenizer.bos_token_id],
        [tokenizer.eos_token_id],
        ],
    pad_token_id=tokenizer.pad_token_id,
    bos_token_id=tokenizer.bos_token_id,
    eos_token_id=tokenizer.eos_token_id,
    )

for sent in tokenizer.batch_decode(out):
    # Do something for sent
```

これでは複数種類の出力はできません。複数種類出力させたい場合は、

- その分モデルを作成する
- soft parameter-sharing
- hard parameter-sharing

という手法があります。それぞれ一長一短ありますが、今回は hard parameter-sharing を行います。parameter-sharing の詳細は[Parameter Sharing in Deep Learning](https://avivnavon.github.io/blog/parameter-sharing-in-deep-learning/)がわかりやすいです。

まず、この`generate`関数は、`transformers/generation/utils.py`の中にある、`GenerationMixin`内に定義されている`generate`関数を呼び出します。この関数内では、前処理等を行なった後、引数に応じて生成関数を呼び出します。生成関数は、

- `greedy_search`
- `contrastive_search`
- `sample`
- `beam_search`
- `beam_sample`
- `group_beam_search`
- `constrained_beam_search`

が存在します。今回は `sample` を使います。

`sample` では

```python
"""
Parameters
----------
input_ids: 入力のテキストを変換したもの
unfinished_sequences: 生成が終了していないミニバッチは1、終了したミニバッチは0をいれて情報を表すpytorchのarray
"""

# 色々な処理

while True:
    # 色々な処理

    outputs = self(
                **model_inputs,
                return_dict=True,
                output_attentions=output_attentions,
                output_hidden_states=output_hidden_states,
            )

    # 色々な処理

    input_ids = torch.cat([input_ids, next_tokens[:, None]], dim=-1)

    # 色々な処理

    if unfinished_sequences.max() == 0 or stopping_criteria(input_ids, scores):
        if not synced_gpus:
            break
        else:
            this_peer_finished = True

if return_dict_in_generate:
    # Dictの形式でReturn
else:
    return input_ids
```

という流れで、`input_text` の続きを生成します。

具体的にはこの`outputs = self()`の部分で、先ほどの `model` 自身を呼び出しています。そして`model`によって`input_ids`の続きを生成したら、それを`input_ids`に concat します。そして次はこれを入力とします。この流れを繰り返すことで、どんどん文章を生成していきます。

この処理は While 文の中にあり、全てのミニバッチが終了するか(`unfinished_sequences.max() == 0`)、ある基準を満たすと生成が終了します(`stopping_criteria(input_ids, scores)`)。

今回の japanese-gpt2-small は、以下のようなモデル構成になっています。

```
GPT2LMHeadModel(
  (transformer): GPT2Model(
    (wte): Embedding(32000, 768)
    (wpe): Embedding(1024, 768)
    (drop): Dropout(p=0.1, inplace=False)
    (h): ModuleList(
      (0-11): 12 x GPT2Block(
        (ln_1): LayerNorm((768,), eps=1e-05, elementwise_affine=True)
        (attn): GPT2Attention(
          (c_attn): Conv1D()
          (c_proj): Conv1D()
          (attn_dropout): Dropout(p=0.1, inplace=False)
          (resid_dropout): Dropout(p=0.1, inplace=False)
        )
        (ln_2): LayerNorm((768,), eps=1e-05, elementwise_affine=True)
        (mlp): GPT2MLP(
          (c_fc): Conv1D()
          (c_proj): Conv1D()
          (act): NewGELUActivation()
          (dropout): Dropout(p=0.1, inplace=False)
        )
      )
    )
    (ln_f): LayerNorm((768,), eps=1e-05, elementwise_affine=True)
  )
  (lm_head): Linear(in_features=768, out_features=32000, bias=False)
)
```

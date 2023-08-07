# GPT=2 について

論文は[こちら](https://paperswithcode.com/paper/language-models-are-unsupervised-multitask)。

インプット＋タスクを渡して解かせるモデル。

モデルとデータを大きくすることで、（なぜかはわからないが）性能がどんどん向上したというもの。よりひろくのタスクに転移学習での対応が可能で、zero-shot も強い。この流れは GPT3 にも引き継がれている。

## モデル

Transformer がベースで、基本的には transformer が n 層積み重なり、その後に出力用の Head 層を置いたもの。

ただし、transformer に以下の変更を加えている。

- Layer Normalization 層を、各サブブロックの入力の位置に移動
- Layer Normalization 層を、最後の self-attention ブロックの後にも追加

## インプット

Byte-Pair Encoding(BPE)をしている。

ただし、他のモデルは単語単位が多い中、GPT2 は本当の Byte-Pair になっていて、Byte 単位で分割する。具体的な手順は[こちら](https://zenn.dev/sunbluesome/articles/775ffd67fb7454#bpe%E3%81%AE%E5%AE%9F%E8%A1%8C%E6%89%8B%E9%A0%86%E6%A6%82%E8%A6%81)。

## Train

label には、入力を使う。入力との 1 個ずらした時の loss を考え、それを最小化することで文脈的に自然な文章を生成することが可能。

huggingface の transformers では、入力の最初のトークンと出力の最後のトークンを削除し、それに対してクロスエントロピーをとっている。

## 参考文献

- 概要理解に良い
  - [https://data-analytics.fun/2020/11/10/understanding-openai-gpt2/](https://data-analytics.fun/2020/11/10/understanding-openai-gpt2/)
  - [https://zenn.dev/sunbluesome/articles/775ffd67fb7454](https://zenn.dev/sunbluesome/articles/775ffd67fb7454)
- GPT の軌跡
  - [https://toukei-lab.com/gpt](https://toukei-lab.com/gpt)
- 具体的な生成とか
  - [https://huggingface.co/blog/how-to-generate](https://huggingface.co/blog/how-to-generate)

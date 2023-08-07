# Pytorch

## CrossEntorpy

CrossEntropyLoss は、各入力に対する損失を計算するために使用される損失関数の一つであり、多クラス分類タスクにおいて一般的に使用される。

入力として 2 つのテンソルを受け取る。一つは、モデルが予測したクラスの確率分布を表す予測出力（例えば、ソフトマックス関数の出力）、もう一つは、正解のクラスを表すラベル。

ただし、これらのテンソルは多次元の場合があり、CrossEntropyLoss を計算する前に、これらのテンソルをフラット化して 1 次元のベクトルに変換する必要がある。こうすることで、2 つのテンソルをバッチサイズを除いて同じ次元数に揃え、CrossEntropyLoss を正しく計算することができる。

具体的には

```
input = (batch size, input ids size, vocaburary size)
label = (input ids size)
```

## logits について

Softmax に入れる前のやつ

## MacOS13.3 のバグ

MacOS を 13.3 にあげたところ、pytorch で以下のエラーが出るようになった。

```
MPS does not support cumsum op with int64
```

これは[こちら](https://github.com/pytorch/pytorch/issues/96610)で述べられているように、2023 年 4 月 26 日現在、pytorch の nightly 版（preview 版）をダウンロードすることで解決できる。以下コマンド。

```bash
# MPS acceleration is available on MacOS 12.3+
$ pip3 install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cpu
```

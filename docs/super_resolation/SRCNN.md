# SRCNN

CNN を超解像に応用したもの。
畳み込み層を 3 回繰り返す構造をしており、少ない計算量で超解像することができる。
低解像度画像は事前に Bicubic 補間で拡大し、出力画像サイズに合わせて入力する。

### バイキュービック補間法（Bicubic interpolation）

周囲 16 画素の画素値を利用する。距離に応じて関数を使い分け、加重平均を求める。最近傍法やバイリニア補間法よりも計算処理は重いが、画質の劣化を抑えることが出来る。

## 参考

- [SRCNN の説明](https://buildersbox.corp-sansan.com/entry/2019/02/21/110000)
- [バイキュービック補間法の説明](https://algorithm.joho.info/image-processing/bicubic-interpolation/)

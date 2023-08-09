# 誤差関数

## MSLE(平均二乗対数誤差)

$$
\text{MSLE} = \frac{1}{n} \sum^{n}_{i=1} (\log(1+\hat{y_i}) - \log(1+y_i))^2
$$

- $log(0)$を回避するために$+1$している
- 主に回帰問題における出力層の評価関数としても用いられる
  - 損失関数として使われることもある
- いずれの関数から出力される値も, 0 に近いほど良い
- 「予測値／正解値」の比率に着目した指標だと見なすことができる

## 参考

- [［損失関数／評価関数］平均二乗対数誤差（MSLE：Mean Squared Logarithmic Error）／RMSLE（MSLE の平方根）とは？](https://atmarkit.itmedia.co.jp/ait/articles/2106/02/news021.html)

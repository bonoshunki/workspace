# メッシュ簡略化について

- [QEM の説明＋結合について](https://www.jstage.jst.go.jp/article/iieej/45/3/45_318/_pdf/-char/ja)
  - Quadric Error Metrics の略
  - QEM は判定基準
  - 結局、フリップ点には対応の必要あり
- [QEM についての論文](https://ipsj.ixsq.nii.ac.jp/ej/?action=repository_action_common_download&item_id=154267&item_no=1&attribute_id=1&file_no=1)
  - QEM の詳細と、一部改良
- [圧縮方法について](http://www.ddm.mi.uec.ac.jp/papers/seimitsu03.pdf)
  - 転送の際等に使える技術
  - 可逆的なもの
- [裏返り点(flip)の対策について一部記述](https://pr.biprogy.com/tec_info/tr129/12901.pdf)
  - 5 章参照
- [メッシュについての説明](https://pages.mtu.edu/~shene/COURSES/cs3621/SLIDES/Simplification.pdf)
  - おそらくどこかの授業資料
  - メッシュ簡略化の基礎について詳しく記載
  - 頂点の分類等が書いてあってわかりやすい
    - Each vertex is assigned one of five possible classifications: simple, complex, boundary, interior edge interior edge, or corner vertex.
- [Meshlab の Non manifold egeds に対する対応](https://mathgrrl.com/hacktastic/2017/02/quick-fixes-with-meshlab/)
  - 浮いているメッシュについて、Meshlab が実装している対応策について記載あり

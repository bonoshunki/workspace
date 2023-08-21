# Monorepo と Polyrepo

## Monorepo と Polyrepo とは

- Monorepo
  - アプリケーションやマイクロサービスの全てのコードをモノリシックなリポジトリで管理する.
- Polyrepo
  - 分割する.

## メリデメ

### Monorepo

- メリット
  - システムに必要なコンポーネントが全て 1 つのリポジトリに集約されている
    - システム全体の把握が容易
    - コンポーネント同士の依存関係や共有コードの管理が容易
  - 参照するコードが常に Single Source of Truth
    - コンポーネント間のコンフリクトも起きにくい
  - Pull Request ベース開発との相性
    - [メルカリの記事](https://engineering.mercari.com/blog/entry/20210810-mercari-shops-tech-stack/)参照
  - コードをリファクタリングしやすい
    - コードの構造変更も行える
    - ソース コードを移動する際も、リポジトリ間ではなくフォルダーやサブフォルダー間で移動すればよいので、手間がかからない
- デメリット
  - 共通のコードを変更すると、数多くのアプリケーション コンポーネントに影響が及ぶ
  - ソースの競合によりマージしにくい場合がある
  - デプロイプロセスが複雑化する可能性
    - ソース管理システムのスケーリングも必要
  - リポジトリの肥大化
    - CI など繰り返し初回 clone を行う環境ではこの時間や容量がそのまま問題

### Polyrepo

- メリット
  - チームが 1 つだけでありその規模が小さければ、マイクロサービスを迅速に実装し、担当者が別々にデプロイを行なうことで、ソフトウェア開発のスピードを大きく高められる
- デメリット
  - 複数のリポジトリを各担当チームがバラバラにメンテナンスするので、システムに関する知識が分散
    - システム全体をビルドしデプロイする方法を知っている人がだれもいないという事態

## 参考

- https://engineering.mercari.com/blog/entry/20210810-mercari-shops-tech-stack/
- https://circleci.com/ja/blog/monorepo-dev-practices/
- https://tech.asoview.co.jp/entry/2022/12/23/095914
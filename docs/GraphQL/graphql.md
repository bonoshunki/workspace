# GranphQL

## GraphQL とは

- GraphQL isn't tied to any specific database or storage engine and is instead backed by your existing code and data.
- Send a GraphQL query to your API and get exactly what you need, nothing more and nothing less. GraphQL queries always return predictable results. Apps using GraphQL are fast and stable because they control the data they get, not the server.
- GraphQL queries access not just the properties of one resource but also smoothly follow references between them. While typical REST APIs require loading from multiple URLs, GraphQL APIs get all the data your app needs in a single request. Apps using GraphQL can be quick even on slow mobile network connections.
- スキーマにより型安全な開発ができる.
- 独自のクエリ言語によって一度のリクエストで過不足なくデータが取得できる.

## 特徴

### メリット

- RestAPI だと, 複数の必要な情報がある場合それぞれの API から取得して必要な属性を取捨選択し → 結合する.
- GraphQL では必要なデータと必要なフィールドを指定して取得することができる.
  - 様々なエンドポイントから必要なデータを取得して結合するといったことが不要.

### デメリット

- クエリを順番に処理していくため N+1 問題が発生しやすい
  - dataloader ライブラリの遅延読み込みで対応
- 単一のエンドポイントに対してリクエストを投げるため URL ベースのキャッシュが行えない
  - 専用のクライアントライブラリを利用する
    - Apollo Client
    - Relay

## 考えておいた方が良いこと

[メルカリの記事](https://engineering.mercari.com/blog/entry/20220303-concerns-with-using-graphql/)がめちゃめちゃ参考になる.

- `Mutation`のレスポンス表現
  - これは REST の場合も同じことが言えるが、クライアントにリソースの変更内容を通知するために, `Mutation`の返却値は変化が起きたリソースをそのまま返すのが望ましい.

## 参考

- [https://graphql.org/](https://graphql.org/)
- [https://zenn.dev/harusame0616/articles/170b6ae38de086](https://zenn.dev/harusame0616/articles/170b6ae38de086)
- [https://engineering.mercari.com/blog/entry/20220303-concerns-with-using-graphql/](https://engineering.mercari.com/blog/entry/20220303-concerns-with-using-graphql/)

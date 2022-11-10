# Riverpod について

Provider パッケージの製作者が作った、Provider パッケージの後継改良版のようなもの。

## Provider

値を読み取るためだけに使うイメージ。

## StateProvider

値を読み取り、変更・更新する際に使う。イメージ的には、その場のみで必要な動的な値を管理するに使う。

## StateNotifierProvider

値を読み取り、変更・更新する際に使う。イメージ的には、複数の場面で必要な値を管理したいするのに使う。TodoList 等。DB を利用する場合もこっち？

## ChangeNotifierProvider

StateNotifierProvider と同じ役割。こちらは Provider パッケージからの移行がしやすいように作成されたもの。また、ルーティングに Navigation 2.0 系（主に Go router）を利用している場合もこちらを利用する必要がある。

ただし、StateNotifierProvider が immutable なのに対し、こちらは mutable であるので、基本避ける。

Go router を用いている場合でも、以下のような方法で避けることも可能。

- https://zenn.dev/mkikuchi/articles/cc87c84e1404c4
- https://www.sugitlab.dev/posts/go-router-with-riverpod

## WidgetsBindingObserver

アプリのライフサイクルを監視するためのもの。こちらは、initState 等で初期化して利用するが、Riverpod にはそこらへんがないため、Provider として用意する。以下参照。

- https://zenn.dev/riscait/books/flutter-riverpod-practical-introduction/viewer/v2-app-lifecycle

## 参考文献

- flutter と Riverpod での開発について詳しくまとめてある
  - https://zenn.dev/riscait/books/flutter-riverpod-practical-introduction/viewer/v2-app-lifecycle

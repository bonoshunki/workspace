# Flutter について

## Widget, Element, RenderObject の概念

以下を見ると理解しやすい

- [https://zenn.dev/chooyan/books/934f823764db62/viewer/703605](https://zenn.dev/chooyan/books/934f823764db62/viewer/703605)
- [https://blog.recruit.co.jp/rls/2019-12-24-flutter-rendering/](https://blog.recruit.co.jp/rls/2019-12-24-flutter-rendering/)
- [https://zenn.dev/kazutxt/books/flutter_practice_introduction/viewer/54_chapter6_tree](https://zenn.dev/kazutxt/books/flutter_practice_introduction/viewer/54_chapter6_tree)

簡単に説明すると、軽量化、効率化等のために、実際に内部的には 3 種類のオブジェクトにより管理している。

- Widget
  - 何回も破棄・生成される用のもの
  - immutable（変更不可能）
  - Widget を管理する（構成を管理する）
- Element
  - 変更されるようのもの
  - mutable
  - Widget、RenderObject の管理に使われる
- RenderObject
  - 変更されるようのもの
  - mutable
  - 画面のレンダリングを管理する

Element、RenderObject に関しては再利用が可能で、最適に再利用されるようになっている。例えば、Widget が変更される場合でも、性質が同じであれば再利用される。

また、これらは Tree 構造により管理される。

(追記) Widget のみ変更され, 内部の Element と RenderObject が使いまわされた結果, 値の更新が走らない場合があった. その場合は明示的に Key を渡すことで解決できるが, そうなっている時点でまずい気もする.

## Buildcontext

位置関係を把握するためのもの。`_child`で子要素を、`of`で親要素を参照できる。

## InheritedWidget

ある Widget から値を参照する時に、context を遡って参照しても良いが、コストがかなりかかってしまう。そのために、引数を渡して下に伝えていっても良いが、コードが煩雑になるのと、値が変更されると、引数に取っている Widget は関係あってもなくても強制的に再構成される。

以上の欠点を改善するためのものが、InheritedWidget である。O(1)で参照できる上、特定の Widget のみ再構成するといったようなことができる。

これをより使いやすくしたものが、Flutter 1 で流行っていた Provider パッケージや、Flutter 2 で流行っている Riverpod パッケージである（ただし、厳密には Riverpod は InheritedWidget をスクラッチから作り直したものらしい）。

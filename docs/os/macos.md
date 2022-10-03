# MacOS について

## hosts

/etc/hosts のファイルに、'ip アドレス host 名'の形式で追記をすることで、host 名でアクセスした際に ip アドレスに名前解決してくれる。クロスドメインやクロスオリジンの検証をローカルで行いたい場合等に活用できる。

- 例

```
127.0.0.1 example.com
```

## Clang

Clang とは、MacOS にて Gcc の代わりの担うものであるが（標準では g++を呼び出すと Clang が実行される）、実態は全くの別。

簡単には

- GCC
  - GCC しかサポートしていない CPU アーキテクチャもある（らしい）
  - C/C++しかサポートしていない
  - 競技プログラミングに便利なライブラリがある
  - GCC の中身はだいぶカオスになっているとよく言われている
  - 大昔から標準だったので GCC 前提のプログラムも多い
- Clang
  - GCC より一般的に高速
  - C/C++以外の言語もサポートしている（改めて環境構築する必要がない）
  - Clang は 0 から作っているので内部がスッキリしている
  - 非互換部分もあるので GCC を前提としたプログラムが全く同様にビルドできるかどうかはわからない
- その他 - 両者でライセンスが異なるので要注意（商用アプリなら Clang の方がライセンス的にやりやすい）

らしい（こぴぺ）。

# 出典

- https://jp.quora.com/GCC%E3%81%A8Clang%E3%81%A9%E3%81%A1%E3%82%89%E3%81%8C%E3%81%8A%E3%81%99%E3%81%99%E3%82%81%E3%81%A7%E3%81%99%E3%81%8B
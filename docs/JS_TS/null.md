# `Null`について

## `Object`型

JS ではプリミティブのように見えるが, `typeof`で検索すると`object`を return する.

```JS
console.log(typeof null); // "object"
```

これはバグだと考えられているが, たくさんのコードを破壊してしまうので修正できない.

## `undefined`との使い分け

基本的に`undefined`を使おう

## 出典

- https://developer.mozilla.org/en-US/docs/Glossary/Null
- https://zenn.dev/saki/articles/48425da2f1e8a0

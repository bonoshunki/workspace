# Shell script

## お決まり

```sh
#!/bin/sh
set -eu
```

を最初に記述する。

set -eu とは、不都合なことが起きた際に、shell scipt の実行を中断してくれるものである。e がエラー発生時、u が未定義の変数利用時に中断する設定である。

- 一部無効化する方法

```sh
#!/bin/sh
set -eu
# お決まり

set +e
# ここは-eが無効化される
set -e
# 再度有効化される
```

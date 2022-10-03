# Git 基本コマンド

## 初期設定をする

- 既存リポジトリを git にあげる場合

```sh
$ git init
$ echo '# ${PROJECT_NAME}' >> README.md
$ git add README.md
$ git commit -m 'first commit'
$ git remote add origin ${URL}
$ git push -u origin main
```

以下コマンドで、origin の設定を確認できる

```sh
$ git remote -v
```

## add 関係

- add

```sh
$ git add ${FILE_NAME}
$ git add .
```

で git に追加できる。

## コミットの取り消し

直前のコミットのみ取り消したい場合

```sh
$ git reset --soft HEAD^
```

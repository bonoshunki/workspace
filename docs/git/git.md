# Git基本コマンド

## 初期設定をする

- 既存リポジトリをgitにあげる場合
```
$ git init
$ echo '# ${PROJECT_NAME}' >> README.md
$ git add README.md
$ git commit -m 'first commit'
$ git remote add origin ${URL}
$ git push -u origin main
```

以下コマンドで、originの設定を確認できる
```
$ git remote -v
```
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

リソースの変更から取り消したい場合

```sh
$ git reset --hard HEAD^
```

## add の取り消し

add を取り消したい場合

```sh
$ git reset HEAD
```

## push の取り消し

- 履歴を残したくない場合
  - コミットの取り消しをおこなった後に、push する。ただし、そのままだと git に以前のコミットと conflict すると怒られるので、`-f`で上書きする。
    ```sh
    $ git reset --soft HEAD^
    $ git push -f
    ```
- 履歴を残したい場合
  - revert というコマンドで変更を打ち消して、コミットし直す。
    ```sh
    $ git revert HEAD
    $ git push origin HEAD
    ```

## 複数アカウントの使い分け

[こちら](https://zenn.dev/taichifukumoto/articles/how-to-use-multiple-github-accounts)の記事が最強.

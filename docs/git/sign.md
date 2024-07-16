# 署名について

## git のメールアドレスを変更した場合

git のメールアドレスを変更した場合、key のメールアドレスと不一致を起こし、署名がうまくいかなくなる。

```shell
gpg --edit-key ${KEY_ID}
gpg> adduid
```

シェルの指示に従って入力する。

```
[  究極  ] (1)  ${NAME} <${EMAIL_1}>
[  不明  ] (2). ${NAME} <${EMAIL_2}>
```

```shell
gpg> save
```

## エラーが出る

Mac の再起動や、他のパッケージの影響により急にエラーが出ることがある。

```log
error: gpg failed to sign the data:
```

その場合の対応リスト。

### `.zshrc`を確認する

以下が記載されているか確認する。なければ追記。

```shell
export GPG_TTY=$(tty)
```

### キャッシュを削除する

gpg のキャッシュが原因の場合がある。とりあえずキャッシュを削除してみる。

```shell
gpgconf --kill all
```

### 鍵の状態を確認する

[参照](https://zenn.dev/kawarimidoll/scraps/74779919683dad)

## 出典

- [https://zenn.dev/kawarimidoll/scraps/74779919683dad](https://zenn.dev/kawarimidoll/scraps/74779919683dad)

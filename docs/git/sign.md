# 署名について

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

# ssh について

## 鍵生成

以下のコマンドで可能。

```
$ ssh-keygen -t ed25519 -f $KEY_NAME
```

## 楽にする

`~/.ssh/config`を作成し、以下のように記入する。

```
Host {NAME}
    Hostname {IP Address}
    User {Username}
    Port 22
    IdentityFile "{PATH TO THE KEY}"
```

すると、以下のコマンドで楽に ssh できる。

```
$ ssh {NAME}
```

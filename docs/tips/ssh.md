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

## scp のエラー

ssh は通るが、scp は通らない場合がある。いかに一例ではあるが原因と解決方法を乗せておく。

まずエラーコードは以下。

```
scp: Received message too long 1887004014
scp: Ensure the remote shell produces no output for non-interactive sessions.
```

僕の場合は、`.bashrc` に記述してあった、以下のコードが原因であった。

```bash
export PYENV_ROOT="~/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
```

このコードが、interactive でない shell(つまり scp の時)にも実行され、エラーが出ていた。sftp でも同様の現象に陥るらしい。

解決策は以下。

`.bashrc`の一部を以下のどちらかに変更。

```bash
if [ -n "$PS1" ]; then
  # execute pyenv only for interactive shells
  eval "$(pyenv init -)"
fi
```

```bash
# initialize pyenv only for non-SSH interactive shells
if [[ -n "$PS1" && -z "$SSH_CLIENT" && -z "$SSH_TTY" ]]; then
  eval "$(pyenv init -)"
fi
```

これで、non-interactive な shell で実行されなくなる。

また、[こちら](https://web.archive.org/web/20191021051539/https://www.complang.tuwien.ac.at/doc/openssh-server/faq.html#2.9)に記述があるように、一旦以下のコマンドで原因が`.bashrc`等に記載の初期化コマンドかをまず確認すると良い。

```bash
$ ssh yourhost /usr/bin/true
```

## 踏み台を経由する

踏み台サーバーを経由する場合は、以下のように記述する。

```
HOST $踏み台の識別子（踏み台用なので、適当なな名前が良い）
        Hostname $IP
        User $USERNAME
        Port $PORT
        IdentityFile $PATH
        ForwardAgent yes

HOST $目的の識別子
        Hostname $IP
        User $USERNAME
        IdentityFile $PATH
        ProxyCommand ssh -W %h:%p $踏み台の識別子
```

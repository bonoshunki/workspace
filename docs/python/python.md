# Python について

## site-packages

pip で導入したものなどが入る場所。例えば外部パッケージを追加したい場合等に、site-packages に入れることで import できるようになるが、案外場所がわからない。例えば pyenv を使っていたりするとなおさら。その際は、以下のコードで場所を確認できる。

```bash
python -c "import site; print (site.getsitepackages())"
```

## pyenv

まず、brew でインストールする。

```
$ brew install pyenv
```

そうしたら、初期設定

```
$ pyenv init
```

自動設定するために〜と表示されるので、従って実行。そうしたら、利用したいバージョンを導入する。

```
$ pyenv install --list
$ pyenv install ${VERSION}
```

--list で利用できるバージョン一覧が見れる。そうしたら、

```
$ pyenv global ${VERSION}
$ pyenv local ${VERSION}
```

でバージョンを切り替える。global の方は全体に適用、local の方は現在いるディレクトリのみ適用。

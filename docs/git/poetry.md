# Poetry

python でのパッケージ管理は基本的には pip を用いるが、pip よりも多機能であり、慣れれば便利である。例えばバージョン管理がしやすかったり、仮想環境ごと管理できたりする。

## インストール

macOS は以下コマンドで導入できる。

```
$ brew install poetry
```

以下コマンドで、path が通っているか確認できる。

```
$ poetry --version
> Poetry version 1.1.13
```

mac 以外は[ここ](https://python-poetry.org/docs/master/#installing-with-the-official-installer)参照。

## 初期設定

- 新しくプロジェクトを作成する
  以下コマンドでプロジェクトを作成できる。

```
$ poetry new ${PROJECT_NAME}
```

- 既存のプロジェクトに導入する
  既存プロジェクトのディレクトリに移動し、以下コマンド実行

```
$ poetry init
```

なお、仮想環境も自動で作成されるので、特に作成する必要はない。

## 基本操作

- インストール

以下コマンドで、追加されているパッケージを一括インストールできる。

```
$ poetry install
```

依存関係が不要な場合は

```
$ poetry install --no-dev
```

とする。

- 追加

以下コマンドで、パッケージをインストールおよび設定ファイルに追加できる。

```
$ poetry add ${PACKAGE_NAME}
```

- 削除

以下コマンドで、パッケージをアンインストール及び設定ファイルから削除できる。

```
$ poetry remove ${PACKAGE_NAME}
```

- version 更新

以下コマンドで、パッケージのバージョンを最新に変更できる。

```
$ poetry update ${PACKAGE_NAME}
```

なお、指定の version にしたい場合は、pyproject.toml を手動で変更しても良い。

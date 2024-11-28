# UV

rust で書かれている、パッケージ管理のツール。とにかく爆速。簡単なプレイグラウンド等はこれで管理するのが便利。

開発元は、ruff を作成している astral。

## インストール

```sh
curl -LsSf https://astral.sh/uv/install.sh | sh
```

## 利用

以下のコマンドで初期設定。

```sh
# ディレクトリ下にいる場合
uv init

# ディレクトリから作成したい場合
uv init $PROJECT_NAME
```

以下のコマンドで、パッケージを追加。

```sh
uv add $PACKAGE_NAME
```

以下のコマンドで、環境に設定を反映。

```sh
uv sync
```

何かしらのパッケージが追加された時点（ `add` or `sync` ）で仮想環境が作成されているはずなので、いつも通り仮想環境に入れば良い。

```sh
. .venv/bin/activate
```

## 出典

- [公式サイト](https://astral.sh/blog/uv-unified-python-packaging)

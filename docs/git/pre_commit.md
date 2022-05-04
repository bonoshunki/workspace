# Pre commit

python と git で開発する際に、commit の前にフィルターを挟むことができる。可読性を上げることはもちろん、複数人での開発では、様式の統一を行うことができ、便利である。

## install

pip を用いている場合は上、poetry を用いている場合は下のコマンドで、pre-commit を導入する。

```
$ pip install pre-commit
$ poetry add pre-commit
```

インストールできているかどうかは、以下のコマンドで確認可能。

```
$ pre-commit --version
> pre-commit 2.18.1
```

## 設定ファイル作成

以下コマンドで、設定ファイルを作成する。

```
$ pre-commit sample-config > .pre-commit-config.yaml
```

なお、以下コマンドで作成しない場合でも、ファイル名は'.pre-commit-config'とする。拡張子は yaml 以外も大丈夫らしい？

そうしたら、設定ファイルを作成。構成は基本的に以下。

```yaml
repos:
  - repo: ${GITHUB_URL}
    rev: ${VERSION/BRANCH_NAME/TAG}
    hooks:
      - id: ${ID}
      - id: ${ID}
```

repo には使用する hooks の github の URL、rev には hooks のバージョンもしくはブランチ名もしくは github のタグを指定する。

hooks には、使用する hook の id を指定する（複数指定可能）。その他のパラメータもここに追加で設定できる（exclude_types や args 等）。

## 実際に使用する

まず、以下を実行する。そうすると、pre-commit が有効になる。

```
$ pre-commit install
```

あとは、普通に add して commit すれば良い。なお、pre-commit に引っかかった場合は、必要があれば該当箇所を修正してから add からやり直す（自動である程度修正してくれる）。

## [番外編]pre-commit を利用したくない場合

特定のコミットのみ反映したくなければ、-n(no verification)を指定すれば良い。

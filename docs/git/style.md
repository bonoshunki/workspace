# 規則について

個人的な守って行きたい規則や、開発をしていて便利だった規則などを記載する。

## ブランチの切り方について

複数人開発では、基本機能ベースでブランチをきる。

こまめにプルリク → マージの流れを踏めれば良いが、踏めない場合もあるので、そのような場合はファイルの変更の衝突が減ったり、作業がしやすくなると言った利点がある。

機能ベースで切る場合は、`${prefix}/${func_name}`のような形式を取るといい。ただし、一番大事なのは統一感を持たせることなので注意。

prefix には以下を使う（git-flow ベース）。

- main
- develop
- feature
  - 新機能を実装するブランチ
- release
  - リリースを行うブランチ
- hotfix
  - 緊急で修正を行うブランチ
- support
  - 古いバージョンをサポートするブランチ

## コミットメッセージについて

prefix は[こちら](https://gist.github.com/joshbuchea/6f47e86d2510bce28f8e7f42ae84c716#semantic-commit-messages)参照。

一覧は以下。

- feat: (new feature for the user, not a new feature for build script)
- fix: (bug fix for the user, not a fix to a build script)
- docs: (changes to the documentation)
- style: (formatting, missing semi colons, etc; no production code change)
- refactor: (refactoring production code, eg. renaming a variable)
- test: (adding missing tests, refactoring tests; no production code change)
- chore: (updating grunt tasks etc; no production code change)

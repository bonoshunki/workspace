# Pandas について

主に Tips 集。

## MultiIndex の中で、特定の Index の値のみ取得したい

MultiIndex において index1, index2...と存在する時に、index1 の値飲み取得したい場合は以下。

```python
df.index.get_level_values('index1')
```

## 一部の文字を置き換えたい

DataFrame のデータのうち, 一部の文字を置き換えたい場合がある. 例えば改行文字が手打ちで入ってしまっているデータを取り出す場合. 以下のコマンドで実行可能.

```python
import pandas as pd

df.replace('(.*)\n(.*)', r'\1,\2', regex=True)
```

`\1`はここでは`\n`より前の文字列, `\2`はここでは`\n`より後の文字列を表す.

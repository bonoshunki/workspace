# Pandas について

主に Tips 集。

## MultiIndex の中で、特定の Index の値のみ取得したい

MultiIndex において index1, index2...と存在する時に、index1 の値飲み取得したい場合は以下。

```python
df.index.get_level_values('index1')
```

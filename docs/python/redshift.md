# RedShift

## CSV に吐き出す

以下のコマンドで吐き出せる. 調べると, `psql`コマンドを使って吐き出したり, `/COPY`コマンドで出力したりする方法が出てくるが, python なら区切り文字等何も考えなくて良い. 楽.

```python
import redshift_connector
import pandas as pd

conn = redshift_connector.connect(
     host='hosturl',
     database='dbname',
     port=5439,
     user='user',
     password='pass'
  )

cursor = conn.cursor()

cursor.execute("SQL")
result: pd.DataFrame = cursor.fetch_dataframe()

result.to_csv("OUTPUT_PATH")
```

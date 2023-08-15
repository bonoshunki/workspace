# CTranslate2

- 生成時に爆速にしてくれるやつ
- 公式
  - https://github.com/OpenNMT/CTranslate2#ctranslate2
- MPT の生成コード（公式）
  - [https://opennmt.net/CTranslate2/guides/transformers.html?highlight=gpt neox#mpt](https://opennmt.net/CTranslate2/guides/transformers.html?highlight=gpt%20neox#mpt)

## 利用方法

### インストール

```
pip install ctranslate2
```

### model のコンバート

```
ct2-transformers-converter --model mosaicml/mpt-7b --output_dir mpt-7b --quantization int8_float16 --trust_remote_code
```

finetuning した後の model を利用したい場合は, --model の後に`.bin`(もしくはおそらく`.pt`もいける)ファイルが入っているディレクトリまでのパスを指定すれば良い.

### 推論

```python
import ctranslate2
import transformers

generator = ctranslate2.Generator("mpt-7b")
tokenizer = transformers.AutoTokenizer.from_pretrained("EleutherAI/gpt-neox-20b")

prompt = "In a shocking finding, scientists"
tokens = tokenizer.convert_ids_to_tokens(tokenizer.encode(prompt))

results = generator.generate_batch([tokens], max_length=30, sampling_topk=10)

text = tokenizer.decode(results[0].sequences_ids[0])
print(text)
```

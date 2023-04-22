# Token について

NLP では、基本的には入力は Tokenizer により Token 化する。

## [Senterpiece](https://github.com/google/sentencepiece)

Google の作成した教師なしのトークナイザー。

perplexity.ai に聞いた特徴は以下。

- 事前にトークンの数が決まっていることが特徴で、​ 生の文章からトレーニングを行う
- 空白は基本的なシンボルとして扱われ、​ サブワードの正則化が行われる
- 日本語のようなスペースで単語が区切られていない言語にも対応している

​SentencePiece によって作成されたトークナイザーは、​BERT や GPT などの自然言語処理タスクに使用される。Tokernizer と形態素解析は全くの別物であることに注意が必要。あくまで処理しやすいように分割・トークン化するだけ。[参考](https://qiita.com/halhorn/items/675be9559ed92e1c2049)。

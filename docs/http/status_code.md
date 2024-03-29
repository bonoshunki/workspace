# ステータスコード

http のステータスコードのうち、よく利用しそうなもの一覧をまとめたもの。基本的に利用する機会があれば更新する。

## 100 番台（情報レスポンス）

- 特になし？現状あまりみない。

## 200 番台（成功レスポンス）

- 200 OK
  - リクエストが成功した。
    - GET: リソースが読み込まれ、メッセージ本文で転送された。
    - HEAD: メッセージ本文がなく、表現ヘッダーがレスポンスに含まれている。
    - PUT or POST: 操作の結果を表すリソースがメッセージ本文で送信される。
    - TRACE: メッセージ本文に、サーバーが受け取ったリクエストメッセージが含まれている。
- 201 Created
  - リクエストが成功し、その結果新たなリソースが作成された。
  - 一般的に、 POST や、一部の PUT へのレスポンス。
- 202 Accepted
  - リクエストは受理されたが、まだ実行されていない。
  - リクエストは別のプロセスかサーバーが処理する、またはバッチ処理する。

## 300 番台（リダイレクトメッセージ）

- 特になし？現状あまりみない。

## 400 番台（クライアントエラーレスポンス）

- 400 Bad Request
  - 構文が無効
- 401 Unauthorized
  - 意味的にはこのレスポンスは "unauthenticated" (未認証) 。
  - 認証情報が含まれていない。
- 403 Forbidden
  - 認証されていないなどの理由でクライアントにコンテンツのアクセス権がない。
  - 401 Unauthorized とは異なり、クライアントの ID がサーバーに知られている
- 404 Not Found
  - サーバーがリクエストされたリソースを発見できないこと
    - ブラウザでは、これは URL が解釈できなかったことを意味する。
    - API では、これは通信先が有効であるものの、リソース自体が存在しないことを意味する。
      - サーバーは認証されていないクライアントからリソースの存在を隠すために、 403 の代わりにこのレスポンスを返すことがある。
- 405 Method Not Allowed
  - サーバーがリクエストメソッドを理解しているが、無効にされており使用することができない。
- 406 Not Acceptable
  - Accept 関連のヘッダに不適切な内容が含まれている。
- 409 Conflict
  - リクエストがサーバーの現在の状態と矛盾している。

## 500 番台（サーバーエラーレスポンス）

- 500 Internal Server Error
  - サーバー側で処理方法がわからない事態が発生した。
- 501 Not Implemented
  - リクエストメソッドをサーバーが対応しておらず、扱えないことを示す。
  - サーバーが対応しなければならないメソッドは GET と HEAD だけです。
- 502 Bad Gateway
  - リクエストの処理に必要なレスポンスを受け取るゲートウェイとして動作するサーバーが無効なレスポンスを受け取ったことを示す。
- 503 Service Unavailable
  - サーバーはリクエストを処理する準備ができていないことを示す。一時的な状況について使用するもの。
  - 一般的な原因は、サーバーがメンテナンスや過負荷でダウンしていること。 ユーザーにわかりやすいページを送信するべき。
  - 可能であれば、サービスが復旧する前に HTTP の Retry-After ヘッダーに予定時刻を含める。
  - 一時的な状況のレスポンスは通常キャッシュされるべきではないので、ウェブ管理者はこのレスポンスとともに送られるキャッシュ関連のヘッダーに注意する。
- 504 Gateway Timeout
  - このエラーレスポンスは、ゲートウェイとして動作するサーバーが時間内にレスポンスを得られない場合に送られる。

## 出典

- [MDN](https://developer.mozilla.org/ja/docs/Web/HTTP/Status)

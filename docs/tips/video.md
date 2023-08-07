# 動画について

## 拡張子とコーデックの違い

拡張子はコンテナのようなもので、コーデックは中身のようなもの。実は拡張子でこのコーデック！みたいなものはない（通例的によく使われる組み合わせや相性の良い組み合わせはもちろん存在するが）。

例えば、mp4 に対して h264 もあるし、vp9 も存在する。

## Shaka-Player、Shaka-Streamer

Google 製の動画周りのライブラリ。非常に便利。

Shaka-Player は、動画の再生を簡単にできるライブラリ。

Shaka-Streamer は、動画の変換周りを簡単にできるライブラリ。簡単には、以下の性質がある。

- Simple, config-file-based application
- No complicated command-lines
- Sane defaults
- Reusable configs
- Runs on Linux, macOS, and Windows
- Supports almost any input FFmpeg can ingest
- Can push output automatically to Google Cloud Storage or Amazon S3
- FFmpeg and Shaka Packager binaries provided

また、これらを利用する場合は、Shaka-Packager を導入する必要がある。

Github は以下。

- Shaka-Player
  - [https://github.com/shaka-project/shaka-player](https://github.com/shaka-project/shaka-player)
- Shaka-Streamer
  - [https://github.com/shaka-project/shaka-streamer](https://github.com/shaka-project/shaka-streamer)
- Shaka-Packager
  - [https://github.com/shaka-project/shaka-packager](https://github.com/shaka-project/shaka-packager)

# Shaka-Streamer の install

## 事前準備

Shaka Streamer を利用するには、PyYaml と、Shaka-packager と呼ばれるものと ffmpeg を事前に導入しておく必要がある。この際に、Shaka-Streamer の開発が Shaka-packager と ffmpeg 両方を簡単に導入できる binary を用意してくれているのだが、M1 には対応していなくて困った。M1 以外は以下のコマンドで済む。

```
# To install/upgrade globally (drop the "sudo" for Windows):
$ sudo pip3 install --upgrade pyyaml

$ pip3 install shaka-streamer-binaries
```

くわしくは[こちら](https://google.github.io/shaka-streamer/prerequisites.html)。

そうしたら次に、Encoding をするための設定を行う必要がある。Mac を使っている場合は必要ない。Linux、Ubuntu を使っている場合は[こちら](https://google.github.io/shaka-streamer/hardware_encoding.html)を参照。

---

以下 M1 マックのみ参照

### build をする

build は[こちら](https://google.github.io/shaka-packager/html/build_instructions.html)の指示に従えばできる。

ただし、Mac を使用している場合は issue#660 にも記述がある通り、SDK のバージョンが 10.15 以降ではエラーが発生してしまうので、SDK のバージョンを 10.14 以前に下げておく必要がある。詳しくは[issue#660](https://github.com/google/shaka-packager/issues/660#issuecomment-552576341)参照。

ただし、M1 では build もできない可能性がある。その際は大人しくビルド済みのものをコピーする。やることは

- GitHub から shaka-packager のビルド済みバイナリをダウンロードして適当な場所に配置 →PATH に追加
- shaka-streamer (shaka-streamer-binaries ではなく) を pip でインストール
- brew で ffmpeg をインストール

## Shaka-Streamer の導入

Shaka-Streamer のインストールは

```
# To install globally (drop the "sudo" for Windows):
$ sudo pip3 install --upgrade shaka-streamer

# To install per-user:
$ pip3 install --user --upgrade shaka-streamer
```

で簡単にできる。

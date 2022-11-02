# FFmpeg

## Openh264 について

ffmpeg が標準で利用している、h264 に対するエンコーダーである x264 は、ライセンスが GPL である。これは嫌う人が多くいるため、代わりに BSD ライセンスで公開されている openh264 を導入する場合が多い。

付属の`build_ffmpeg.sh`を使うと、簡単にビルドできる。対応環境は ubuntu18.04(多分 20.04 もいける).

## コーデックをインストールしているのに、エラーが発生する

```sh
ffmpeg: error while loading shared libraries: libopenh264.so.5: cannot open shared object file: No such file or directory
```

anaconda 環境で以上のようなエラーが発生した場合、以下のコマンドを実行する。

```
$ conda update ffmpeg
```

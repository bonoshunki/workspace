# FFmpeg

## コーデックをインストールしているのに、エラーが発生する

```sh
ffmpeg: error while loading shared libraries: libopenh264.so.5: cannot open shared object file: No such file or directory
```

anaconda 環境で以上のようなエラーが発生した場合、以下のコマンドを実行する。

```
$ conda update ffmpeg
```

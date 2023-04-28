# ImageMagick について

## convert heic to jpg

heic を jpg に変換する。フォーマットの部分やファイル拡張子をよしなに変更すればいろいろ対応できるが、コーデックがインストールされている必要あり。

```bash
$ mogrify -format jpg *.heic
```

この方法だと変換前のものは削除されないので注意。

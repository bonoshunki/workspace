# FBX について

## AutoDesk 製のフォーマット

3D モデルデータをやりとりにデファクトスタンダードに近い形で使われている。フォーマットの割には仕様が不明瞭だったりツールごとの対応に差があって困る。

構造は以下

- シリアライズフォーマット
  - ツリー構造を持つ Node
  - Node は名前といくつかの Attribute を持つ
  - ASCII と Binary フォーマットの二種類ある
- FBX Object
  - ID(整数値)，種類(Model,Material,Geometry など)，プロパティ等を持つ
  - オブジェクト間の参照関係を持つ
  - オブジェクトの種類ごとにデフォルト値などを定義した PropertyTemplate がある
- シーングラフ
  - Model, Geometry, Material, Deformer 等の FBX Object で構成されるシーン
  - Model がユーザが目にするツリーを構成するオブジェクト
  - Model が Geometry, Material などを参照する

## M1 mac で AutoDesk 製 SDK を利用する

Python は M1 非対応。C++は少し大変

動的利用は以下のコード

```sh
$ sudo install_name_tool -id "/Applications/Autodesk/FBX SDK/2020.3.2/lib/clang/debug/libfbxsdk.dylib" "/Applications/Autodesk/FBX SDK/2020.3.2/lib/clang/debug/libfbxsdk.dylib"
$ g++ -L"/Applications/Autodesk/FBX SDK/2020.3.2/lib/clang/debug" -I"/Applications/Autodesk/FBX SDK/2020.3.2/include" -lfbxsdk -std=c++11 test.cpp
```

静的利用はさらに追加で処理必須。https://qiita.com/1024chon/items/a1b1eedba7781a61cf5e 参照。

## Fbx SDK を利用する際

[このフォーラム](https://forums.autodesk.com/t5/fbx-forum/bd-p/area-b64)にかなり有益情報が含まれているので、参考にすると良い。

# 出典

- https://qiita.com/binzume/items/678baf9a20c6a96a1d81
- https://ja.wikipedia.org/wiki/FBX
- https://yttm-work.jp/model_render/model_render_0008.html
- https://hobbyistbox.hatenablog.com/entry/2016/02/19/002609
- https://splunktool.com/convert-obj-to-fbx-with-python-fbx-sdk
- http://marupeke296.com/FBX_No7_TextureMaterial.html

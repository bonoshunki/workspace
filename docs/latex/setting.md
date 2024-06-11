# 設定

主に VScode での設定について。

## formatter

1. Perl を導入する

    ```bash
    brew install perl
    brew install cpanm
    cpanm Log::Log4perl Log::Dispatch::File YAML::Tiny File::HomeDir Unicode::GCString
    ```

1. `settings.json` を書き換える

    ```json
    "[latex]": {
        "editor.formatOnSave": true,
        "editor.defaultFormatter": "James-Yu.latex-workshop",

    },
    "latex-workshop.latexindent.path": "latexindent",
    "latex-workshop.latexindent.args": [
        "%TMPFILE%",
        "-c=%DIR%/",
        "-y=defaultIndent: '%INDENT%'"
    ]
    ```

参考

- <https://qiita.com/Yarakashi_Kikohshi/items/1a275f2046b002e398b3#-formatter>
- <https://zenn.dev/ganariya/articles/vscode-latex-indent>

# CMake

##　バージョン変更方法(Linux)
以下のコマンドをバージョンに合わせて実行する

```
sudo apt install build-essential checkinstall zlib1g-dev libssl-dev -y
wget https://github.com/Kitware/CMake/releases/download/v3.23.3/cmake-3.23.3.tar.gz
tar -zxvf cmake-3.23.3.tar.gz
cd cmake-3.23.3
sudo ./bootstrap
sudo make
sudo make install
hash -r
cmake --version
```

# 出典

- https://zenn.dev/suudai/articles/8b484ac39fde38

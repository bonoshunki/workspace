# Disk 周り

ハードウェアとの接続周りは意外とわからないことが多いのでまとめる.

## 利用できる Disk を確認する

`lsblk`コマンド. `MOUNTPOINT`が指定されているものはマウントされていてすでに利用できるもの.

```bash
$ lsblk
NAME          MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
nvme1n1       259:0    0  10G  0 disk
nvme0n1       259:1    0   8G  0 disk
-nvme0n1p1    259:2    0   8G  0 part /
-nvme0n1p128  259:3    0   1M  0 part
```

## 新しい Disk をマウントする

以下のような構成と仮定する.

```bash
$ lsblk
NAME          MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
nvme1n1       259:0    0  10G  0 disk
nvme0n1       259:1    0   8G  0 disk
-nvme0n1p1    259:2    0   8G  0 part /
-nvme0n1p128  259:3    0   1M  0 part
```

まず, ボリュームにファイルシステムがあるかどうかを確認する. ない場合は以下のような出力.

```bash
$ sudo file -s /dev/nvme1n1
/dev/xvdf: data
```

ある場合は以下のような出力になる. この場合すでにマウントされているか, ファイルシステムを作って放置しているかのどちらか. 前者の場合めんどくさいことになるのでちゃんと確認すること.

```bash
$ sudo file -s /dev/nvme0n1p1
/dev/nvme0n1p1: SGI XFS filesystem data (blksz 4096, inosz 512, v2 dirs)
```

ない場合, マウントして使用する前にボリュームにファイルシステムを作成する必要がある. (ある場合は次は飛ばす)

```bash
$ sudo mkfs -t xfs /dev/nvme1n1
```

そうしたら, マウント先を作成.

```bash
$ sudo mkdir /data
```

マウントしたら, `/data`を新しい disk として利用できる.

```bash
$ sudo mount /dev/nvme1n1 /data
```

## 参考

- [https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/ebs-using-volumes.html](https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/ebs-using-volumes.html)

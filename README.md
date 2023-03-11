# xuperchain-demo

一键部署多个 xuperchain 区块链节点

## 步骤

1. `git clone` 本项目。

1. 在 [xuperchain](https://github.com/xuperchain/xuperchain) 项目中 `make` 得到 `output` 目录。将 `output` 目录拷贝到本项目目录下。完成后，本项目的文件结构应大致如下所示：
```txt
.
├── _check-node.sh
├── check-nodes.sh
├── 省略 ……
├── output
│		 ├── bin
│		 │		 ├── wasm2c
│		 │		 ├── xchain
│		 │		 └── xchain-cli
│		 ├── conf
│		 │		 ├── contract.yaml
│		 │		 ├── 省略 ……
│		 ├── control.sh
│		 └── 省略 ……
├── run-server.sh
├── _start-node.sh
├── 省略 ……
```

1. `ssh-keygen` 生成一对 SSH 公私钥。

1. 购买一台云服务器实例，当作导演服务器。该服务器通过刚才生成的私钥登录。

1. 购买 N 台云服务器实例，当作区块链节点。这些服务器通过刚才生成的私钥登录。

1. 把 SSH 私钥复制到导演服务器的 `~/.ssh/xuperchain_ecdsa`，然后 `chmod` 改权限为 `600`。

1. 在导演服务器中安装 Caddy。在 [GitHub Release](https://github.com/caddyserver/caddy/releases/) 中下载并放置到 `/usr/local/bin` 下即可。注意确保 `caddy` 文件具有 `x` 权限。

1. 在导演服务器中修改 `_start-node.sh` 文件，将 HTTP 服务器的 IP 地址改为导演服务器的 IP 地址。

1. 在导演服务器中修改 `nodes-config.sh` 文件，填写 N 台区块链节点的 IP 地址。

1. 在导演服务器中修改 `gen-genesis.sh` 文件，指向希望使用的共识算法。具体共识参数可在对应的 `.py` 文件中修改。

1. 在导演服务器中执行 `deploy.sh` 文件，生成 N 台区块链节点的配置文件。

1. 在导演服务器中执行 `run-server.sh` 文件，运行 Caddy 服务器。请在单独的 `tmux` 会话下执行此步骤。

1. 在导演服务器中执行 `start-nodes.sh` 文件，批量运行 N 台区块链节点。

1. 在导演服务器中执行 `check-nodes.sh` 文件，测试 N 台区块链节点的运行情况。

1. 在导演服务器中执行 `stop-nodes.sh` 文件，停止区块链节点的运行。

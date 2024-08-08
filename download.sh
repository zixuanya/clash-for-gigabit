#!/bin/sh

# 设置目标路径
Temp_Dir="/usr/data/clash/temp"
Env_File="/usr/data/clash/.env"

# 检查并加载 .env 文件
Server_Dir=$(cd $(dirname "$0") && pwd)
echo "默认路径： $Server_Dir"

if [ -f "$Env_File" ]; then
    . "$Env_File"
    echo "成功加载 env 配置文件"
else
    echo "无法找到 .env 文件"
    exit 1
fi

# 检查旧的配置文件
if [ -f "$Temp_Dir/clash.yaml" ]; then
    echo "发现旧的配置文件，你是否要删除旧的配置文件并下载新的？ (y/n)"
    read -r choice

    if [ "$choice" = "y" ]; then
        rm "$Temp_Dir/clash.yaml"
        echo "旧的 Clash 配置文件已删除"
    else
        echo "保留旧的 Clash 配置文件，停止脚本"
        exit 0
    fi
fi

# 询问用户是否使用 SUBCONVERT_API
echo "是否使用 SUBCONVERT_API 进行订阅转换来下载配置文件？ (y/n)"
read -r use_subconvert

# 下载新的配置文件
echo "正在下载新的配置文件..."

if [ "$use_subconvert" = "y" ]; then
    download_url="${SUBCONVERT_API}/sub?target=clash&url=${URL}&insert=false&config=https%3A%2F%2Fraw.githubusercontent.com%2FACL4SSR%2FACL4SSR%2Fmaster%2FClash%2Fconfig%2FACL4SSR_Online_Full_NoAuto.ini&emoji=true&list=false&xudp=false&udp=false&tfo=false&expand=true&scv=false&fdn=false&new_name=true"
else
    download_url="$URL"
fi

wget -O "$Temp_Dir/clash.yaml" "$download_url" &

# 等待 100 秒
echo "正在下载，脚本将等待 100 秒..."
sleep 300

# 验证配置文件是否存在
if [ -f "$Temp_Dir/clash.yaml" ]; then
    echo "配置文件存在，安装完成"
    echo "现在重新启动服务..."
    sh "$Server_Dir/restart.sh"
else
    echo "配置文件不存在，可能下载过程中出错"
    exit 1
fi

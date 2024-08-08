#!/bin/sh

# 获取脚本工作目录绝对路径
Server_Dir=$(cd $(dirname "$0") && pwd)
echo "Server_Dir: $Server_Dir"

# 加载.env变量文件
if [ -f "$Server_Dir/.env" ]; then
    . "$Server_Dir/.env"
else
    echo "Error: .env file not found!"
    exit 1
fi
echo "已加载 .env 文件"

# 调试变量替换
if [ -z "$CLASH_SECRET" ]; then
    Secret=$(openssl rand -hex 32)
else
    Secret=$CLASH_SECRET
fi
echo "Secret: $Secret"

# 给二进制启动程序、脚本等添加可执行权限
chmod +x "$Server_Dir/bin/"*
chmod +x "$Server_Dir/scripts/"*
chmod +x "$Server_Dir/tools/subconverter/subconverter"

# 设置目录变量
Conf_Dir="$Server_Dir/conf"
Temp_Dir="$Server_Dir/temp"
Log_Dir="$Server_Dir/logs"

# 自定义action函数，实现通用action功能
success() {
    echo -en "\\033[60G[\\033[1;32m  OK  \\033[0;39m]\r"
    return 0
}

failure() {
    local rc=$?
    echo -en "\\033[60G[\\033[1;31mFAILED\\033[0;39m]\r"
    [ -x /bin/plymouth ] && /bin/plymouth --details
    return $rc
}

action() {
    local STRING rc

    STRING=$1
    echo -n "$STRING "
    shift
    "$@" && success $"$STRING" || failure $"$STRING"
    rc=$?
    echo
    return $rc
}

if_success() {
    local ReturnStatus=$3
    if [ $ReturnStatus -eq 0 ]; then
        action "$1" /bin/true
    else
        action "$2" /bin/false
        exit 1
    fi
}

# 临时取消环境变量
unset http_proxy
unset https_proxy
unset no_proxy
unset HTTP_PROXY
unset HTTPS_PROXY
unset NO_PROXY

# 使用已有的clash.yaml文件
echo -e '\n正在使用已有的Clash配置文件...'
cp -a "$Temp_Dir/clash.yaml" "$Temp_Dir/clash_config.yaml"

# Clash 配置文件重新格式化及配置
sed -n '/^proxies:/,$p' "$Temp_Dir/clash_config.yaml" > "$Temp_Dir/proxy.txt"

# 合并形成新的config.yaml
cat "$Temp_Dir/templete_config.yaml" > "$Temp_Dir/config.yaml"
cat "$Temp_Dir/proxy.txt" >> "$Temp_Dir/config.yaml"
cp "$Temp_Dir/config.yaml" "$Conf_Dir/"

# Configure Clash Dashboard
Work_Dir=$(cd $(dirname $0) && pwd)
Dashboard_Dir="${Work_Dir}/dashboard/public"
sed -ri "s@^# external-ui:.*@external-ui: ${Dashboard_Dir}@g" "$Conf_Dir/config.yaml"
sed -ri "/^secret: /s@(secret: ).*@\1${Secret}@g" "$Conf_Dir/config.yaml"

# 启动Clash服务
echo -e '\n正在启动Clash服务...'
Text5="服务启动成功！"
Text6="服务启动失败！"
nohup "$Server_Dir/bin/clash-linux-armv7" -d "$Conf_Dir" > "$Log_Dir/clash.log" 2>&1 &
ReturnStatus=$?
if_success "$Text5" "$Text6" $ReturnStatus

# 输出Dashboard访问地址和Secret
echo ''
echo -e "Clash Dashboard 访问地址: http://<ip>:9090/ui"
echo -e "Secret: ${Secret}"
echo ''


#!/bin/sh

# 查找 clash 服务的 PID
PIDS=$(pgrep -f 'clash-linux-armv7')

# 调试输出 PID 列表
echo "找到的 PID 列表: $PIDS"

# 如果找到了 PID，则逐个终止进程
for PID in $PIDS; do
  if [ -n "$PID" ]; then
    echo "终止进程: $PID"
    kill -9 $PID
  fi
done

# 输出信息
echo "服务关闭成功，请执行以下命令关闭系统代理：proxy_off"


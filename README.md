

# 项目介绍

此项目旨在吉比特光伏光猫运行[mihomo core](https://github.com/MetaCubeX/mihomo/releases)（[shellcrash](https://github.com/juewuy/ShellCrash)编译版本）来实现家庭网络代理，方便快捷的使用网络代理，无需购买高额的软路由用作科学上网

<br>

# 建议配置

CPU ***大于但是不等于*** 1 core

RAM ***大于*** 200 MB

磁盘剩余空间 ***大于或等于*** 100 MB

swap 是 可选 的

# 使用须知

- 本项目***只能供给***吉比特设备使用，尽管可能在其他类似于armv7l架构相似的设备上能够运行，但***并不提供任何issues支持***，运行本项目之前，请确保您拥有上文符合要求的设备的吉比特光伏设备。
- 使用过程中如遇到问题，可以提交[issues](https://github.com/zelgezhi/clash-for-Gigabit/issues)反馈（如果我没事干的话
- 本项目基于 [mihomo]([https://github.com/Dreamacro/clash](https://github.com/MetaCubeX/mihomo/releases)) 、[yacd一件管理面板](https://github.com/haishanh/yacd) 进行的配置整合，相关内容可以查阅对方仓库寻求帮助
- 此项目不提供任何订阅信息，请自行准备 Clash 订阅地址，subconvert 转换地址
- 运行前请手动更改 `.env` 文件中的全部变量值，否则无法正常运行。
- 当前在移动光猫 GM220-S 得到充分测试（时长＞24小时），大致符合使用日常需求，以及最低标准
- 理论上，这个代码支持 armv7l，armv6 等后系设备，但***并不提供issues支持***
- 使用本项目前，你都需要了解贵国法律政策，上述代码脚本仅作演示用途，禁止用于任何违法，违规行为，由自己行为带来的法律指控或者刑事诉讼，原作者以及现作者不负任何刑事责任
- 本软件完全开源，禁止用于售卖教程等盈利行为
- 对于clash兼容，目前已知能运行shellcrash版本，大致和原版mihomo相似

<br>

# 使用教程

clash.la
nodeseek.........

# 相关命令
```
sh start.sh
```

启动 mohomo 和 yacd 面板
```
sh download.sh
```

下载配置文件，删除老旧的配置文件

```
sh restart.sh
```

完整重启 mohomo 和 yacd 服务

```
sh shutdown.sh
```

完整 关闭 所有服务

## 效果演示

![image](https://github.com/user-attachments/assets/b3b19a35-2e53-4248-a3f0-c9ccb4f558b8)

![image](https://github.com/user-attachments/assets/b65ae678-9493-4875-a40b-e15b7a945a1e)

# 项目灵感和致谢

项目灵感：https://github.com/wanhebin/clash-for-linux （已经删库）

感谢[wanhebin](https://github.com/wanhebin)提供最初源码解决光猫部署clash面板合一问题

最后的最后，感谢那些陪伴我的每一位

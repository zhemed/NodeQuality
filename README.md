# NodeQuality
在沙箱环境中运行vps测试脚本，并排版测试结果

> 本仓库基于 [LloydAsp/NodeQuality](https://github.com/LloydAsp/NodeQuality)（AGPL-3.0）改造，
> 并自建了报告托管后端与前端页面。测试脚本部分来自 [xykt](https://github.com/xykt)，
> 原作者与来源见 [NOTICE](./NOTICE)。

本项目本质上是测试工具集合的**前置加载器和结果后处理**项目。把服务器测试工作的流程给规范化自动化了。
让测试仅仅是测试，不要留下一堆痕迹；让测试可以更舒服省心，自动排版截图。

## 特性总结

- 全面**拥抱 [xykt](https://github.com/xykt) 脚本方案**，补充其他测试信息，减少重复测试
- 切换到一个专用的临时**准系统**内测试，测完自动清理，极致的干净，做到**无痕测试**
- 支持对运行结果自动**导出统一的markdown**格式，[IpQuality](https://www.nodeseek.com/post-105666-1)和[NetQuality](https://www.nodeseek.com/post-287967-1)结果自动截图

使用命令为：
```
bash <(curl -sL https://raw.githubusercontent.com/zhemed/NodeQuality/refs/heads/main/NodeQuality.sh)
```

### 自建服务端

报告页与上传接口已独立实现，配套仓库：

- [nodequality-server](https://github.com/zhemed/nodequality-server)：Rust 后端，收包 / 存包 / 发包
- [nodequality-web](https://github.com/zhemed/nodequality-web)：Vue3 + xterm.js 报告页

脚本里三处基础设施地址都可用环境变量覆盖，默认值暂为上游：

| 变量 | 说明 |
| --- | --- |
| `NQ_API_BASE` | 上传接口所在站点，例如 `http://10.0.0.1:8090` |
| `NQ_RAW_PREFIX` | `part/*.sh` 的拉取地址前缀 |
| `NQ_BENCHOS_URL` | BenchOS 镜像地址 |

例如把结果传到自建服务端：

```bash
NQ_API_BASE=http://10.0.0.1:8090 bash NodeQuality.sh
```
## 沙箱隔离，无痕测试
测试脚本往往需要加载很多软件和工具，符合**把各种专用工具串起来解决问题的linux哲学**。 为了减少测试过程中安装的软件和产生的临时文件占用空间，将所有测试放在**BenchOS**内。 chroot特别适合作为测试脚本的沙箱工具，因为其**不用额外安装、极致的轻量、只有文件隔离而没有网络和内存隔离**。

具体的沙箱化方案：
- 使用一个debian系统的rootfs作为测试的准系统
- 使用chroot临时切换到准系统(称为BenchOS)，无需重装系统或者安装docker/虚拟机
- 在BenchOS内**预装好常见的程序**，使用时**进行挂载，使用后进行卸载，自动删除准系统数据**，干干净净，清清爽爽
- 除了需要curl下载文件的命令，**不需要额外安装**任何程序到vps上
- 测试完传到临时剪切板网页，清理所有加载的数据

## 自动排版，自动截图，自动传图床，一键导出
配套提供一个**现代化**的网页粘贴板和排版工具，保留了原有的文本高亮。
IP质量 和 网络质量 的结果自动截图，预留一定的边距，使其更加美观。

[预览地址](https://nodequality.com/r/IHfGBj2jD8OT7BqBNUbCWTWV3XRIbpMB)

## “拼好脚本”，减少重复测试

目前方案是选取了**Yabs + IP质量 + 网络质量 + 融合怪的部分功能**，重新整合后的脚本。这种组合兼顾信息的全面性和直观性。

## 致谢
特别感谢[xykt](https://github.com/xykt)，本项目归根到底是**以xy脚本为核心的封装和后处理**；项目名也来自于xykt。

感谢[融合怪脚本](https://github.com/spiritLHLS/ecs)，为了保证可比性，sysbench部分采用了融合怪的脚本片段

感谢[16图床](https://111666.best/)提供的图片数据储存支持和上传接口对接协助

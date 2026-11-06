#!/bin/bash

HEADING_DATE="$(TZ='Asia/Shanghai' date +'%Y-%m-%d %H:%M:%S CST')"
# 一键命令入口；自有域名上线后只需改这里的默认值
NQ_RUN_URL="${NQ_RUN_URL:-https://raw.githubusercontent.com/zhemed/NodeQuality/refs/heads/main/NodeQuality.sh}"
echo -ne "\e[0;36m"
cat <<-EOF
########################################################################
                  bash <(curl -sL $NQ_RUN_URL)
                   https://github.com/zhemed/NodeQuality
        报告时间：$HEADING_DATE  脚本版本：v0.1.0
        测试脚本：xykt (IP.Check.Place / Net.Check.Place / Hardware.Check.Place)
        原始项目：LloydAsp/NodeQuality
########################################################################
EOF
echo -ne "\033[0m"

#!/usr/bin/env bash

#设置定时任务，每5分钟
rm -f cornjob
cFolder="$(pwd)"
echo "*/5 * * * * $cFolder/havenwall.sh >> /tmp/bw.out" >> cornjob
#设定定时任务
crontab cornjob
#获得一次壁纸
./havenwall.sh  >> /tmp/bw.out

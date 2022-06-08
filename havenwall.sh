#!/usr/bin/env bash

#创建壁纸目录

if [[ $1 = "-n" ]]
then
    osascript -e "display notification \"开始更换壁纸\" with title \"定时换壁纸\""
fi

mkdir -p ~/havenwalls/
cd ~/havenwalls/

#请求 wallhaven api 获得一张壁纸
#url_result="$(/usr/local/bin/curl/bin/curl --location --request GET 'https://wallhaven.cc/api/v1/search?q=id%3A853&resolutions=3840x2160&sorting=random&page=1&categories=110' | grep -o '"path":"[^"]*"' | head -n 1 |sed -e 's/"path":"//' | sed -e 's/"//' | sed -e 's/\\//g')"
url_result="$(/usr/local/opt/curl/bin/curl --location --request GET 'https://wallhaven.cc/api/v1/search?q=id%3A1240&atleast=3840x2160&ratios=16x9&sorting=random&page=1&categories=111' | grep -o '"path":"[^"]*"' | head -n 1 |sed -e 's/"path":"//' | sed -e 's/"//' | sed -e 's/\\//g')"

rm -rf havenwall*.jpg

#随机文件名，否则无法更换壁纸
file_seed="$(date +%s)"

#下载壁纸
/usr/local/opt/curl/bin/curl $url_result -o havenwall_$file_seed.jpg
#设置壁纸路径
localpath="/Users/$USER/havenwalls/havenwall_$file_seed.jpg"
#设置壁纸
#osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$localpath\""
osascript -e "tell application \"System Events\" to set picture of (reference to every desktop) to \"$localpath\""

#提示壁纸设置成功
if [[ $1 = "-n" ]]
then
    osascript -e "display notification \"壁纸更换成功\" with title \"定时换壁纸\""
fi

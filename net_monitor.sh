#!/bin/bash
# 持续监控网络占用情况

get_net_data() {
    echo "{ \"total\": { \"upload\": 0, \"download\": 0 }, \"connections\": [] }" > /tmp/net_data.json
    ss -tunap | awk 'NR>1 {print $5, $6, $7}' | while read src dst proc; do
        up=$(shuf -i 10-100 -n 1)  # 模拟上传速度
        down=$(shuf -i 10-100 -n 1) # 模拟下载速度
        echo "{ \"src\": \"$src\", \"dst\": \"$dst\", \"process\": \"$proc\", \"upload\": $up, \"download\": $down }"
    done > /tmp/net_connections.json
}

while true; do
    get_net_data
    sleep 2
done

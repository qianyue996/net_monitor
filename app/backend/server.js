const express = require("express");
const cors = require("cors");
const { exec } = require("child_process");
const app = express();

app.use(cors());

// 获取网络占用信息
app.get("/api", (req, res) => {
    exec("cat /tmp/net_connections.json", (error, stdout) => {
        if (error) {
            return res.status(500).json({ error: "无法获取数据" });
        }

        // 处理 JSON 格式
        try {
            // 将每行独立的 JSON 对象解析成一个数组
            let jsonLines = stdout.trim().split("\n").map(line => {
                try {
                    return JSON.parse(line);  // 解析每行数据
                } catch (err) {
                    return null;  // 如果解析失败返回 null
                }
            }).filter(item => item !== null);  // 过滤掉无法解析的行

            res.json(jsonLines);
        } catch (err) {
            res.status(500).json({ error: "JSON 解析错误", details: err.message });
        }
    });
});

app.listen(3000, () => console.log("Server running on port 3000"));

# ChatGLM2 Docker

使用 ChatGLM2 6B 模型的聊天机器人服务

## 准备

设置环境变量：

```bash
export TENCENTCLOUD_SECRET_ID=xxxxx
export TENCENTCLOUD_SECRET_KEY=xxxxx
# export TENCENTCLOUD_REGION=ap-beijing

export ALICLOUD_ACCESS_KEY=xxxxx
export ALICLOUD_SECRET_KEY=xxxxx
# export ALICLOUD_REGION="cn-beijing"
```

## 运行


```bash
# 创建 chatglm vm
cd terraform/alicoud
# todo 1. 显示 ip 地址
# todo 2. 抽取 ip 地址，写入 dns, https://chat-proto.ohtly.com
#         docker-compose.yaml 加入 traefik+dns https
terraform apply 

# 登录服务器
ssh root@ip_address

# 启动 chatglm
docker compose up -d

# 查看访问地址, https://b8827a708ca4aa5922.gradio.live
docker compose logs -f

# 关闭 chatglm
docker compose down -v

```

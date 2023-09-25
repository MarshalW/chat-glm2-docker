# ChatGLM2 Docker

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

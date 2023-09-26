
# 调试记录，不能直接运行

sudo apt update && sudo apt upgrade -y

# 安装驱动
sudo apt install nvidia-driver-525 -y -qq
# 或者 - 腾讯云可以
sudo ubuntu-drivers autoinstall
# 需要重启
sudo reboot

# 测试驱动是否有效
nvidia-smi

# 安装 docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# 安装 nvidia container toolkit
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list \
  && \
    sudo apt-get update
sudo apt-get install nvidia-container-toolkit -qq -y
sudo systemctl restart docker

# # 下载 pytorch && cuda runtime
docker pull nvidia/cuda:12.2.0-devel-ubuntu22.04
# docker pull pytorch/pytorch:2.0.1-cuda11.7-cudnn8-runtime

# 上传文件
scp ../../docker-compose.yaml root@47.245.120.11:~
scp ../../Dockerfile root@47.245.120.11:~

# 启动 nvidia 服务
docker compose up -d

# 进入容器
docker exec -it proto bash

# 测试驱动是否有效
nvidia-smi
watch -n1 nvidia-smi

# 测试 cuda 是否正常
# ./test.py
import torch
print(torch.cuda.is_available()) # should be True

t = torch.rand(10, 10).cuda()
print(t.device) # should be CUDA


FROM nvidia/cuda:12.2.0-devel-ubuntu22.04

RUN apt-get update \
    && apt-get install \
        python3 \
        python3-pip \
        git \
        -y -qq

RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

WORKDIR /project
RUN git clone https://github.com/THUDM/ChatGLM2-6B.git

WORKDIR /project/ChatGLM2-6B
RUN pip3 install -r requirements.txt

RUN sed -e '$s/share=False/share=True/' web_demo.py > web_demo_remote.py

CMD ["python3","web_demo_remote.py"]
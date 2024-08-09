FROM nvcr.io/nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get install -y sudo python3 python3-pip git curl build-essential

# RustとCargoをインストール
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# requirements.txtをコンテナにコピー
RUN pip3 install --upgrade pip
COPY requirements.txt /tmp/requirements.txt
# pip install で必要なパッケージをインストール
RUN pip3 install -r /tmp/requirements.txt

RUN pip3 install wheel 
RUN pip3 install flash-attn --no-build-isolation
RUN pip3 install -U transformers

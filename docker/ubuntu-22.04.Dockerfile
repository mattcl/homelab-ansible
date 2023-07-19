FROM ubuntu:22.04

RUN apt update && \
    apt install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-apt \
    sudo \
    && python3 -m pip install ansible ansible-lint

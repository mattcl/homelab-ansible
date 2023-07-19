FROM ubuntu:22.04

RUN apt update && \
    apt install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-apt \  # needed for --check
    sudo \
    && python3 -m pip install ansible ansible-lint

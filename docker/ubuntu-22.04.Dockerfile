# we need a container that has the right user in it, because the playbook is
# sensitive to it
FROM ubuntu:22.04

RUN apt update && \
    apt install -y --no-install-recommends \
    python3 \
    python3-pip \
    sudo \
    && python3 -m pip install ansible

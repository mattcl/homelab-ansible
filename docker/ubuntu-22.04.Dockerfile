# we need a container that has the right user in it, because the playbook is
# sensitive to it
FROM ubuntu:22.04

ARG username=matt

RUN apt update && \
    apt install -y --no-install-recommends \
    python3 \
    python3-pip \
    sudo \
    && python3 -m pip install ansible

RUN useradd \
    --create-home \
    --shell /bin/bash \
    --groups sudo \
    --user-group \
    $username \
    && mkdir -p /etc/sudoers.d \
    && echo "$username ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$username \
    && chmod 0440 /etc/sudoers.d/$username

#!/bin/bash

echo "$VAULT_PASSWORD" > vaultpass

set -ex

# set up the user we need to work with
useradd --create-home --shell /bin/bash --groups sudo --user-group "$CREATE_USER"
mkdir -p /etc/sudoer.d
echo "$CREATE_USER ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/$CREATE_USER"

# check
ansible-playbook -i inventory/test.yml --check --diff --vault-password-file vaultpass "$PLAYBOOK"

rm vaultpass

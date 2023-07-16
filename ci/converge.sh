#!/bin/bash

echo "$VAULT_PASSWORD" -n > vaultpass

set -ex

# set up the user we need to work with
useradd --create-home --shell /bin/bash --groups sudo --user-group "$CREATE_USER"
mkdir -p /etc/sudoer.d
echo "$CREATE_USER ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/$CREATE_USER"

ansible-playbook -i inventory/test.yml --vault-pass-file vaultpass "$ROLE"

rm vaultpass

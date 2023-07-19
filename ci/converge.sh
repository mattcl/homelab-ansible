#!/bin/bash

if [ -z ${LOCAL_TEST+x} ]; then
    echo "$VAULT_PASSWORD" > .vaultpass
else
    echo "Local testing. Skipping creation of vault password file"
fi

set -ex

# set up the user we need to work with
useradd --create-home --shell /bin/bash --groups sudo --user-group "$CREATE_USER"
mkdir -p /etc/sudoer.d
echo "$CREATE_USER ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/$CREATE_USER"

# from scratch
echo "--- FIRST PASS ---"
ansible-playbook -i inventory/test.yml --vault-password-file .vaultpass "$PLAYBOOK"

# second pass to sanity check that we _appear_ idempotent
echo "--- SECOND PASS ---"
ansible-playbook -i inventory/test.yml --vault-password-file .vaultpass "$PLAYBOOK"

if [ -z ${LOCAL_TEST+x} ]; then
    rm .vaultpass
fi

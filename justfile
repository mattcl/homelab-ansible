# run a particular playbook against a particular stage
converge PLAYBOOK STAGE:
    ansible-playbook -i inventory/{{STAGE}}.yml --ask-become-pass --vault-password-file .vaultpass {{PLAYBOOK}}.yml

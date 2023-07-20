# run a particular playbook against a particular stage
converge PLAYBOOK STAGE:
    ansible-playbook -i inventory/{{STAGE}}.yml --ask-become-pass --vault-password-file .vaultpass {{PLAYBOOK}}.yml

# run a test for a particular playbook
test PLAYBOOK:
    docker compose run --rm -e PLAYBOOK={{ PLAYBOOK }} local-converge

# run a test for a particular playbook
sandbox PLAYBOOK:
    docker compose run --rm -e PLAYBOOK={{ PLAYBOOK }} local-sandbox

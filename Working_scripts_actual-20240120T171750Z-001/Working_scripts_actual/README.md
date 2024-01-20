# Provisioning and deploy

## Installation
Install ansible through your distribution package manager or use Docker.

### Suggestions:
    - Arch:         `pacman -S ansible`
    - Deb/Ubuntu:   `apt install ansible`
    - Fedora:       `yum install ansible`

## Install ansible extensions
- `ansible-galaxy collection install ansible.community.general`

## Ensure that you have ssh-keys setup to hosts in hosts.yml
There are other ways to have ansible connect to hosts through ssh. But having
ssh-keys setup on the executing machine is by far the safest and better option.

## Defining hosts
Inside `hosts.yml` all available hosts can be configured and have their unique
values defined.

## Playbooks
Playbooks are defined in the root of the project. Eg. `provision.yml`. You can
define what hosts should be included and what roles that should be run within
the playbook.

## Docker
The docker image we are based on is `archlinux:latest` because it has the
latest version of ansible available.

### Ansible scripts
The local directory is shared with the docker container as a volume. So any
modifications to scripts in this directory will be imediately reflected by
ansible in the docker container.

### Deploying
Deploying the docker image works as usual:

- `docker-compose build`
- `docker-compose up`
- `docker-compose run ansible <ansible-cmd>`

### Security
The docker images will use the "local" machines ssh keys (id_rsa) to
authenticate against its various hosts so make sure you've run `ssh-copy-id
user@host` from the host machine before attempting to run ansible through the
docker container.

The reasoning behind this rather then using a shared key is that you will be
able to revoke individual keys if the need should arise.

### Ansible vault
Ansible vault is what we use to encrypt sensitive data within files and entire files.
To make the whole thing work you need to store the password in a local file `.password`.

```bash
echo 'secret-phrase' > .password
```

A short manual on how to encrypt "in file" values and entire files follows here:

```bash
# Encrypt a variable (string)
ansible-vault encrypt --vault-password-file=.password the-secret-value --name 'the-variable-name'

# Encrypt an entire file
ansible-vault encrypt --vault-password-file=.password <the-file-to-encrypt>
```

Ansible will automatically deal with decrypting values when running the playbooks.

## Run ansible
There is a lot ansible can do. For this particular setup the one important thing
to remember is that you need to specify what 'inventory' file to use. `hosts.yml` in this case.

This gives you the following ansible commands:
- `ansible -i hosts.yml ...`
- `ansible-playbook -i hosts.yml ...`

### Running a playbook
- Check provisioning playbook:
  - `docker-compose run ansible ansible-playbook -i hosts.yml provision.yml --check`
- Check and diff provisioning playbook:
  - `docker-compose run ansible ansible-playbook -i hosts.yml provision.yml --check --diff`
- Run the provisioning playbook (all configured hosts):
  - `docker-compose run ansible ansible-playbook -i hosts.yml provision.yml`
- Run provisioning on a single host:
  - `docker-compose run ansible ansible-playbook -i hosts.yml provision.yml --extra-vars "variable_host=<hostname>"`

### Quick commands
For quality of life the following scripts exist to reduce copy pasting and
typing when provisioning servers with docker.

- `./abl-check`     : Runs ansible without changing anything
- `./abl-provision` : Provisions all or one machine

Read more here: [](https://docs.ansible.com/ansible/latest/cli/ansible-playbook.html)
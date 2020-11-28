# Ansible Role: AWX (open source Ansible Tower)

[![CI](https://github.com/geerlingguy/ansible-role-awx/workflows/CI/badge.svg?event=push)](https://github.com/geerlingguy/ansible-role-awx/actions?query=workflow%3ACI)

Installs and configures [AWX](https://github.com/ansible/awx), the open source version of [Ansible Tower](https://www.ansible.com/tower).

## Requirements

Before this role runs, assuming you want the role to completely set up AWX using it's included installer, you need to make sure the following AWX dependencies are installed:

| Dependency                    | Suggested Role           |
| ----------------------------- | ------------------------ |
| EPEL repo (RedHat OSes only)  | `geerlingguy.repo-epel`  |
| Git                           | `geerlingguy.git`        |
| Ansible                       | `geerlingguy.ansible`    |
| Docker                        | `geerlingguy.docker`     |
| Python Pip                    | `geerlingguy.pip`        |
| Node.js (10.x)                | `geerlingguy.nodejs`     |

See this role's [`molecule/default/converge.yml`](molecule/default/converge.yml) playbook for an example that works across many different OSes.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    awx_repo: https://github.com/ansible/awx.git
    awx_repo_dir: "~/awx"
    awx_version: devel
    awx_keep_updated: true

Key and password variables:

    awx_admin_password: password
    awx_pg_password: awxpass
    awx_secret_key: awxsecret

These are the default passwords and keys used when deploying AWX. For a production setup, it's **highly recommended** that you change all of them, especially the secret key. The playbook will warn you if you are using the default admin password or secret key.

Variables to control what version of AWX is checked out and installed.

    awx_run_install_playbook: true

By default, this role will run the installation playbook included with AWX (which builds a set of containers and runs them). You can disable the playbook run by setting this variable to `false`.

Variables to control AWX workarounds:

    awx_workaround: false

By default, this role will no longer use a workaround that was previously necessary when running AWX for the first time after installation. You can re-enable the workaround by setting this variable to `true`.

## Dependencies

None.

## Example Playbook

```yaml
- hosts: awx-centos
  become: true

  vars:
    nodejs_version: "10.x"
    docker_install_compose: false
    pip_install_packages:
      - name: docker
      - name: docker-compose

  roles:
    - geerlingguy.repo-epel
    - geerlingguy.git
    - geerlingguy.pip
    - geerlingguy.ansible
    - geerlingguy.docker
    - geerlingguy.nodejs
    - geerlingguy.awx
```

After AWX is installed, you can log in with the default username `admin` and password `password`.

## License

MIT / BSD

## Author Information

This role was created in 2017 by [Jeff Geerling](https://www.jeffgeerling.com/), author of [Ansible for DevOps](https://www.ansiblefordevops.com/).

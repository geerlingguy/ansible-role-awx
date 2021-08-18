# Ansible Role: AWX (open source Ansible Tower)

> **DEPRECATED**: This role has been deprecated. AWX installation is a lot different than it was when I first created the role, and continues evolving. Please follow the official install guide and if you need automation around it, please consider the [awx-operator](https://github.com/ansible/awx-operator).

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

Variables to control what version of AWX is checked out and installed.

    awx_run_install_playbook: true

By default, this role will run the installation playbook included with AWX (which builds a set of containers and runs them). You can disable the playbook run by setting this variable to `false`.

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

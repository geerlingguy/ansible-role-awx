# Ansible Role: AWX (open source Ansible Tower)

[![Build Status](https://travis-ci.org/geerlingguy/ansible-role-awx.svg?branch=master)](https://travis-ci.org/geerlingguy/ansible-role-awx)

Installs and configures [AWX](https://github.com/ansible/awx), the open source version of [Ansible Tower](https://www.ansible.com/tower).

## Requirements

Before this role runs, you need to make sure the following AWX dependencies are installed:

| Dependency                    | Suggested Role           |
| ----------------------------- | ------------------------ |
| EPEL repo (RedHat OSes only)  | `geerlingguy.repo-epel`  |
| Git                           | `geerlingguy.git`        |
| Ansible                       | `geerlingguy.ansible`    |
| Docker                        | `geerlingguy.docker`     |
| Python Pip                    | `geerlingguy.pip`        |
| Node.js (6.x)                 | `geerlingguy.nodejs`     |

See this role's `tests/test.yml` playbook for an example that works across many different OSes.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    awx_repo: https://github.com/certbot/certbot.git
    awx_repo_dir: "~/awx/"
    awx_version: devel
    awx_keep_updated: yes

Variables to control what version of AWX is checked out and installed.

## Dependencies

None.

## Example Playbook

    - hosts: awx-centos
      become: yes
    
      vars:
        nodejs_version: "6.x"
        pip_install_packages:
          - name: docker-py
    
      roles:
        - geerlingguy.repo-epel
        - geerlingguy.git
        - geerlingguy.ansible
        - geerlingguy.docker
        - geerlingguy.pip
        - geerlingguy.nodejs
        - role_under_test

### Creating certificates with certbot

After installation, you can create certificates using the `certbot` (or `certbot-auto`) script (use `letsencrypt` on Ubuntu 16.04, or use `/opt/certbot/certbot-auto` if installing from source/Git. Here are some example commands to configure certificates with Certbot:

    # Automatically add certs for all Apache virtualhosts (use with caution!).
    certbot --apache

    # Generate certs, but don't modify Apache configuration (safer).
    certbot --apache certonly

If you want to fully automate the process of adding a new certificate, you can do so using the command line options to register, accept the terms of service, and then generate a cert using the standalone server:

  1. Make sure any services listening on port 80 (Apache, Nginx, Varnish, etc.) are stopped.
  2. Register with something like `certbot register --agree-tos --email [your-email@example.com]`
    - Note: You won't need to do this step in the future, when generating additional certs on the same server.
  3. Generate a cert for a domain whose DNS points to this server: `certbot certonly --noninteractive --standalone -d example.com -d www.example.com`
  4. Re-start whatever was listening on port 80 before.
  5. Update your webserver's virtualhost TLS configuration to point at the new certificate (`fullchain.pem`) and private key (`privkey.pem`) Certbot just generated for the domain you passed in the `certbot` command.
  6. Restart your webserver so it uses the new HTTPS virtualhost configuration.

### Certbot certificate auto-renewal

By default, this role adds a cron job that will renew all installed certificates once per day at the hour and minute of your choosing.

You can test the auto-renewal (without actually renewing the cert) with the command:

    /opt/certbot/certbot-auto renew --dry-run

See full documentation and options on the [Certbot website](https://certbot.eff.org/).

## License

MIT / BSD

## Author Information

This role was created in 2016 by [Jeff Geerling](https://www.jeffgeerling.com/), author of [Ansible for DevOps](https://www.ansiblefordevops.com/).

# Ansible-Docker
An Ansible role for installing configuring Docker projects on a system.

---

## Values

All values are optional unless otherwise marked as required

```yaml
docker:
  version: string                     Indicates the version to install. If empty, latest will be used.
  remove: bool                        Indicates if `Docker` should be remove from the system. Default false.
  compose:
    version: string                   [Required] Indicates the version of `Docker Compose` to install.
    compositions:
      - name: string                  [Required]	Used as project directory name if `destination` is not found.
        source: string                [Required] The local path to the `Docker Compose` project.
        destination: string           The remote location where the project directory should be.
        user: string                  The remote user who should own the project directory, else `root`.
        group: string                 The remote group who should own the project directory, else `root`.
        secrets:
          - name: string              [Required] The name of the file containing the secret at `<project-dir>/secrets/name`.
            value: string | number    The value to set in the secret file. Mutually exlusive with `variable`.
            variable: string          The variable holding the value to set in the secret file. Mutually exlusive with `value`.
            remove: bool              Indicates that this named secret should be removed.
        environment:
          - name: string              [Required] The name of the variable.
            value: string | number    The value to set the variable to. Mutually exlusive with `variable`.
            variable: string          The variable holding the value to set the env variable to. Mutually exlusive with `value`.
            remove: true              Indicates that this named variable should be removed.
```

### Compositions

Compositions will be placed at the remote `destination` if it is defined, otherwise the project dir will be set to `/srv/<name>`. These paths are considered as being `<project-dir>` in the rest of the documentation.

#### Secrets

Secrets are placed along side projects, each into their own file, under `<project-dir>/secrets`. The owner of the directory and every file inside it is `root`. The directory has access mode `700`, with each file inside having mode `600`.

#### Environment

Project environment variables are placed in a file `<project-dir>/.env` with access mode `644`. It will have the owner and group as defined in the composition project fields `<user>` and `<group>` respectively, otherwise `root`.

---

## Requirements

This role requires the `jsonschema` Python package be installed. To do so for example using `pip`:

```shell
pip install jsonschema
```

## Setup

Before the role can be used it needs to be added to the machine running the playbook, and as of writing this, this role is not hosted on Ansible-Galaxy only on Github.

1. Create a `requirements.yml` file in the root directory of the playbook being worked on.

2. Add the following definition inside the `requirements.yml` file:

```yml
- name: hth-docker
  src: https://github.com/hrafnthor/ansible-docker.git
  scm: git
  version: <tag or branch to use>
```

3. Install the requirements by executing:

```shell
ansible-galaxy install -r .requirements.yml
```

This will allow any playbook run from this machine to use the role `hth-android-studio`

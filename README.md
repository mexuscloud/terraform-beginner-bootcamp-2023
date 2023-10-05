# Terraform Beginner Bootcamp 2023

## Semantic Versioning 

This project is going to utilize semantic versioning for its tagging. 
[semver.org](https://semver.org/)

The general format:

**MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI 

### Considerations with the Terraform CLI changes 
The Terraform CLI installation instructions have changed due to [gpg keyring](https://medium.com/@azerella/gpg-for-dummies-5bdde94fa36d) changes. 
We need to refer to the latest install instructions via Terraform documentation and change the scripting for installing Terraform CLI.   

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution

This project is built on Ubuntu. Please consider checking your Linux distro and change accordingly. 

[How to check OS version in Linux](https://opensource.com/article/18/6/linux-version)

Example of checking OS versino 

```cat /etc/os-release```

```sh
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```


### Refactoring into bash scripts 

While fixing the Terraform CLI gpg depreciation issues, we noticed that bash script steps were a considerable amount more code. Based on that, we decided to create a bash script to install the Terraform CLI. 

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli.sh)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy. 
- This will allow an easier way to perform a debug and execute manually Terraform CLI install. 
- This will allow better portablity for other projects that need to inatll Terraform CLI. 

#### Shebang

A Shebang (pronunced Sha-bang) tells the bash script what program that will interpret the script. eg. `#!/bin/bash`

chatGPT recommended this format for bash: `#!/usr/bin/env bash`

- For portablity for different OS distribution
- Will search the user's PATH for the bash executable

[Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))

#### Execution Considerations 

When executing the bash script, we can use the `./` shorthand notation.  

eg. `./bin/install_terraform_cli.sh`

If we are using a script in .gitpod.yml, we need to point the script to a program to interpert it. 

eg. `source ./bin/install_terraform_cli.sh`

#### Linux Permissions considerations  

In order to make our bash script executable, we need to change Linux permission for the file to be executable at the user mode. 

```sh
chmod u+x ./bin/install_terraform_cli.sh
```
Alternatively: 

```sh
chmod 744 ./bin/install_terraform_cli.sh
```

[chmod](https://en.wikipedia.org/wiki/Chmod)

### Gitpod Lifecycle (Befor, Init, Command)

We need to be careful when using init becasue it will not rerun if we restart an existing workspace. 

[Gitpod workspace tasks](https://www.gitpod.io/docs/configure/workspaces/tasks)

### Working with Env Vars 

#### env command 

We can list out all Environment Variables (Env Vars) using the `env` command 

We can filter specific Env Vars using grep. eg. `env | grep AWS` 

#### Setting and unsetting Env Vars

In the terminal we can set using `export HELLO='world'`

we can unset using `unset HELLO`

we can set an Env Var temporarily when just running a command 

```sh
HELLO='world' ./bin/print_message
```

within a bash script we can set an Env Var without writting export

```sh
#!/usr/bin/env bash
HELLO='world'
echo $HELLO
```

#### Printing Env Vars 

we can print an Env Var using echo. eg. `echo $HELLO`

#### Scoping of Env Vars

When you open up a new bash terminals in VSCode it will not be aware of Env Vars that you have set in another window. 

If you want Env Vars to persist across all future bash terminals that are open, you need to set Env Vars in your bash profile. eg. `.bash_profile`

#### Persisting Env Vars in Gitpod 

We can persist Env Vars in Gitpod by storing them in Gitpod Secrets storage. 

```
gp env HELLO='world'

```

All future workspaces launched will set the Env Vars for all bash terminals opened in those workspaces. 

You can also set Env Vars in the `.gitpod.yml` but this can only contain non-sensetive Env Vars. 
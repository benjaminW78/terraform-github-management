Terraform Foxintelligence architecture
======================================

## Introduction

[article for explaining terraform](https://blog.gruntwork.io/why-we-use-terraform-and-not-chef-puppet-ansible-saltstack-or-cloudformation-7989dad2865c)


## Installation

```bash
brew install terraform
terraform --version
```

## Add github repository with default settings

go to `cd ./github-Misterfoxapp/`
open `github-Misterfoxapp.tf`
add template add end of file

```
module "github_repository_<GITHUB_REPOSITORY_NAME>" {
  # (resource arguments)
  source = "default-config/"

  repository_name = "<GITHUB_REPOSITORY_NAME>"
  user_repository_admin = "<GITHUB_ADMIN_USER_NAME>"
  team_admin = "${github_team.admin.id}"
  team_dev = "${github_team.dev.id}"
  team_data = "${github_team.data.id}"
}
```

replace by real values:

    `<GITHUB_REPOSITORY_NAME>`-> new repository name
    `<GITHUB_ADMIN_USER_NAME>`-> user name which will be owner and admin of the repository

```bash
terraform init
terraform fmt  # for indenting and linting your files
terraform plan
```

```
                     /!\ WARNING /!\
/!\ This command can destroy repositories and loose code. /!\
                     /!\ WARNING /!\
```

If everything inside plan was ok run : `terraform apply`

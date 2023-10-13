# Terraform Beginner Bootcamp 2023 - week 1

## Root Module Structure

Our root module structure:

```
PROJECT_ROOT
│
├── main.tf           # everything else
│
├── variables.tf      # stores the structure of input variables
│
├── terraform.tfvars  # the data of variables we want to load into our terraform project
│
├── outputs.tf        # stores our outputs
│
├── providers.tf      # defines required providers and their configuration
│
└── README.md         # required for root modules

```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

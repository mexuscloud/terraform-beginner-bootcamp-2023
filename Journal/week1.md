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

## Terraform and Input Varaibles 

### Terraform Cloud Variables 

In Terraform we can set two kinds of varaibles: 
- **Environment Variables** - set in bash terminal eg. AWS Credentials 
- **Terraform Variables** - normally set in your tfvars file

We can set Terraform Cloud Variables to be sensetive so they are not shown visible in the UI. 

### Loading Terraform Input Variables 

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input varibles or override a variable in the tfvars file. 
eg. `terraform -var user_uuid="my-user-id"`

### Var-file flag

It is used to specify an external file that contains variable values for a Terraform configuration. It allows you to separate your variable values from your main configuration files, making it easier to manage different configurations for various environments or to share configurations with others.

eg. `terraform apply -var-file=dev.tfvars`. 
assuming we have a `dev.tfvars: Contains variable values specific to the development environment.`

### terrafom.tfvars

This is the default file to load in terraform variables in bulk. 

### auto.tfvars

is a special file in Terraform that automatically loads variable values without needing to specify them using the `-var` flag or in a separate variable file.

### Order of terraform variables 

The order of Terraform variables is critical for variable definition and usage. In short:

- **Variable Declaration**: Define variables in your configuration using the variable block.
- **Default Values**: You can specify default values for variables in the variable block.
- **Terraform Configuration**: Variables can be used within your Terraform configurations.
- **Input Values**: You can provide variable values via command-line flags, variable files, or environment variables to override defaults.
- **Variable Precedence**: Terraform follows a hierarchy for variable values, with command-line values taking precedence over defaults, and environment variables taking precedence over variable files.


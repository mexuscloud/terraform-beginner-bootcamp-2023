
# Terraform Beginner Bootcamp 2023 - week 1

## Fixing Tags 

[How to delete local and remote tags on Git](https://dev.to/zigrazor/git-remove-local-and-remote-tag-the-final-guide-534n)

Locally delete a tag  

```sh
git tag -d <tag_name>
```

Remotely delete a tag  

```sh
git push --delete origin <tagname>
```

Checkout the commit that you want to re-tag. grab the sha from your Github history. 

```sh
git checkout <SHA>
git tag M.m.p
git push --tags 
git checkout main
```

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


## Dealing with configuration Drift 

## What happens if we lose our state file?

If you lose your state file, you most likely have to tear down all your cloud infrastructure manually. 

You can use terraform import but it won't work for all cloud resources. You will need to check the terraform providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import 

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)

[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration 

If someone goes and delete or modify resources manually through ClickOps, running Terraform plan will attempt to put our infrastructure back into the expected state fixing configuration drift.  

## Fix using Terraform Refresh 

```sh
terraform apply -refresh-only -auto-approve
```

## Terraform Modules 

### Terraform module structure 

It is recommended to place modules in a `modules` directory when locally developing modules but you can name it whatever you like. 

### Passing Input Variables 

We can pass input variables to our module. 
The module has to declare the terraform variables in its own `variables.tf`

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Module Sources

Using the source we can import the module from various places. eg: 

- Locally 
- Github 
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```

[Module Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations when using ChatGPT to write Terraform 

LLMs such as ChatGPT may not be trained on providing the latest documentation or information about Terraform. 

It may likely generate older examples that could be deprecated and often affecting providers used in the Terraform code. 

## Working with files in Terraform 

### File exists function 

This is a built in Terraform function to check an existence of a file. 

eg. 

```tf
condition = fileexists(var.error_html_filepath)
```

or 

```tf
condition = can(file(var.error_html_filepath))
```

[File exists](https://developer.hashicorp.com/terraform/language/functions/fileexists)

### Filemd5

[Filemd5](https://developer.hashicorp.com/terraform/language/functions/filemd5)

### Path Variable 

In Terraform there is a special variable called `path` that allows us to reference local paths: 

- `path.module` = get the path for the current module. 
- `path.root `= get the path for the root module. 

[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references)

eg. 

```tf
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
}
```

## Terraform Locals 

Locals allows us to define local variables. 
It can be very useful when we need terraform data into another formate and have it referenced as a variable. 

```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```
[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

## Terraform Data Sources 

This allows us to source data from cloud resources. 

This is useful when we want to reference cloud resources without imorting them. 

eg. 

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON 

we use the jsonencode to create the json policy inline in the hcl

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsonencode)](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

### Changing the Lifecycle of Resources 

[Meta Arguments Lifecycles](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data 

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

eg. 

```tf
resource "terraform_data" "content_version" {
  input = var.content_version
}
```

[Terraform Data](https://developer.hashicorp.com/terraform/language/resources/terraform-data)

## Provisioner

Provisioner allow us to execute commands on compute instances eg. AWS CLI command 

They are not recommended for use by Hashicorp because configuration managment tool susch as Ansible are a better fit but the functionality exists.

[Provisioner](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### Local-exec

This will execute commands on the machine runnig the Terraform commands eg. plan apply.

eg. 

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```

[Local-exec](https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec)

### Remote-exec

This will execute commands on the machine which you target. You will need to provide credentials such as ssh to get into the machine.  

eg. 

```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```

[Remote-exec](https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec)
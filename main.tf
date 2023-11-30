terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  cloud {
    organization = "mexuscloud"
    workspaces {
      name = "Terra-house-1"
    }
  }
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_FIFA_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.FIFA.public_path
  content_version = var.FIFA.content_version
}

resource "terratowns_home" "home_FIFA" {
  name = "FIFA - The Game"
  description = <<DESCRIPTION
FIFA is one of the most popular sport games in the world.
The game features realistic graphics, detailed player animations, and immersive gameplay. 
Players can experience various game modes, including career mode, online multiplayer, and tournaments. 
  DESCRIPTION
  domain_name = module.home_FIFA_hosting.domain_name
  town = "missingo"
  content_version = var.FIFA.content_version
}

module "home_KeyLime_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.KeyLime.public_path
  content_version = var.KeyLime.content_version
}

resource "terratowns_home" "home_KeyLime" {
  name = "Making a key lime pie"
  description = <<DESCRIPTION
Key lime pie is a classic dessert known for its tangy, yet sweet flavor. 
It typically consists of a crumbly graham cracker crust filled with a creamy, 
citrusy filling made from key lime juice, condensed milk, and egg yolks. 
The pie is often topped with whipped cream or meringue, 
adding a light and airy contrast to the rich filling. 
Originating from the Florida Keys, this dessert has a refreshing taste 
that's perfect for warmer weather and is beloved for its zesty and indulgent combination of flavors.
  DESCRIPTION
  domain_name = module.home_KeyLime_hosting.domain_name
  town = "missingo"
  content_version = var.KeyLime.content_version
}







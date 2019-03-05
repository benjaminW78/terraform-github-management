# Configure the GitHub Provider
provider "github" {
  token        = "${var.github_token}"
  organization = "${var.github_organization}"
}

resource "github_team" "admin" {
  name        = "Admin"
  description = "yolo"
  privacy     = "secret"
}

resource "github_team" "dev" {
  name        = "Dev"
  description = "developers team"
  privacy     = "secret"
}
/*****************************************
*SERVICES SECTION
*
*****************************************/

// EXAMPLE 
//module "github_repository_yolo" {
//  # (resource arguments)
//  source = "default-config/"
//
//  repository_name       = "service-yolo"
//  user_repository_admin = "benjaminW78"
//  team_admin            = "${github_team.admin.id}"
//  team_dev              = "${github_team.dev.id}"
//  team_data             = "${github_team.data.id}"
//  required_status_checks = []
//  branches_to_protect   = ["master","preprod"]
//}


/*****************************************
*NPM SECTION
*
*****************************************/
//
//module "dev-npm-logger" {
//  # (resource arguments)
//  source = "default-config/"
//
//  repository_name       = "dev-npm-logger"
//  user_repository_admin = "benjaminW78"
//  team_admin            = "${github_team.admin.id}"
//  team_dev              = "${github_team.dev.id}"
//  team_data             = "${github_team.data.id}"
//  insert_team_data      = false
//  use_travis            = false
//  required_status_checks = []
//  branches_to_protect   = ["master","preprod"]
//}

/*****************************************
*APPLICATIONS SECTION
*
*****************************************/
//
//module "app-plop" {
//  # (resource arguments)
//  source = "default-config/"
//
//  repository_name       = "app-flattable"
//  user_repository_admin = "benjaminW78"
//  team_admin            = "${github_team.admin.id}"
//  team_dev              = "${github_team.dev.id}"
//  team_data             = "${github_team.data.id}"
//  required_status_checks = []
//
//}

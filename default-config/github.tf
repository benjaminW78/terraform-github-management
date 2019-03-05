variable "repository_name" {}

variable "user_repository_admin" {}

variable "insert_team_admin" {
  default = true
}

variable "insert_team_dev" {
  default = true
}

variable "insert_team_data" {
  default = true
}

variable "team_admin" {}

variable "team_dev" {}

variable "team_data" {}

variable "allow_merge_commit" {
  default = true
}

variable "allow_squash_merge" {
  default = false
}

variable "allow_rebase_merge" {
  default = true
}

variable "auto_init" {
  default = true
}

variable "git_ignore_type" {
  default = "nodejs"
}

variable "description" {
  default = ""
}

variable "private" {
  default = true
}

variable "has_downloads" {
  default = false
}

variable "has_issues" {
  default = true
}

variable "has_wiki" {
  default = true
}
variable "use_travis" {
  default = true
}
variable "branches_to_protect" {
  type    = "list"
  default = ["master", "preprod","develop"]
}

variable "required_status_checks" {
  type    = "list"
  default = ["continuous-integration/travis-ci"]
}

resource "github_repository" "main" {
  name        = "${var.repository_name}"
  description = "${var.description}"

  private = "${var.private}"

  has_downloads = "${var.has_downloads}"
  has_issues    = "${var.has_issues}"
  has_wiki      = "${var.has_wiki}"

  allow_merge_commit = "${var.allow_merge_commit}"
  allow_squash_merge = "${var.allow_squash_merge}"
  allow_rebase_merge = "${var.allow_rebase_merge}"

  auto_init = "${var.auto_init}"

  lifecycle {
    prevent_destroy = false
  }
}

resource "github_repository_collaborator" "main" {
  repository = "${github_repository.main.name}"
  username   = "${var.user_repository_admin}"
  permission = "admin"
}

# Add a repository to the team

# Add a team to the organization

resource "github_team_repository" "admin" {
  count      = "${var.insert_team_admin}"
  team_id    = "${var.team_admin}"
  repository = "${var.repository_name}"
  permission = "admin"
}

resource "github_team_repository" "dev" {
  count = "${var.insert_team_dev}"

  team_id    = "${var.team_dev}"
  repository = "${var.repository_name}"
  permission = "push"
}

resource "github_team_repository" "data" {
  count      = "${var.insert_team_data}"
  team_id    = "${var.team_data}"
  repository = "${var.repository_name}"
  permission = "push"
}


resource "github_branch_protection" "main" {
  count = "${length(var.branches_to_protect)}"

  repository = "${github_repository.main.name}"
  branch     = "${var.branches_to_protect[count.index]}"

  enforce_admins = false

  required_status_checks {
    strict   = "${var.use_travis}"
    contexts = ["${var.required_status_checks}"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = true
    dismissal_teams       = ["admin"]
  }

  restrictions {
    teams = ["admin"]
  }
}

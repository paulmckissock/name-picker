module "this" {
  source = "github.com/vigetlabs/terraform-context.git?ref=v1.0.0"

  namespace = "vgtinterns"
  tenant    = "spinet"
  stage     = "all"

  tags = {
    "Owner"             = "Viget"
    "Terraform Managed" = "True"
    "Cost Center"       = "interns"
    "Repo" = "https://github.com/vigetlabs/name-picker"
  }
}

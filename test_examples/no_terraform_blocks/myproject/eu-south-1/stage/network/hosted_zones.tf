module "dns_zone" {
  source = "github.com/terraform-aws-modules/terraform-aws-route53/modules/zones"

  zones = {
    "${var.vpc_name}.local" = {
      comment = "Private hosted DNS zone for ${var.vpc_name}"
      tags = {
        Env       = var.vpc_name
        Terraform = "true"
      }
      vpc = [
        {
          vpc_id = module.vpc.vpc_id
        },
        {
          vpc_id = data.aws_vpc.infra.id
        }
      ]
    }
  }
}

data "aws_vpc" "infra" {
  filter {
    name   = "tag:Name"
    values = ["infra-vpc"]
  }
}

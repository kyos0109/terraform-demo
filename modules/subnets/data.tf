# get all subnet id
data "aws_subnet_ids" "all_subnet" {

  vpc_id = "var.vpc_id"

  filter {
    name   = "var.filter_rule.name"
    values = ["var.filter_rule.values"]
  }
}

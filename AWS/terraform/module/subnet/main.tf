resource "aws_subnet" "subnet" {
    for_each = var.aws-subnet
  vpc_id     = var.vpc_id[each.value.vpc-key].id
  cidr_block = each.value.cidr_block

  tags = {
    Name = each.value.subnet-tag
  }
}
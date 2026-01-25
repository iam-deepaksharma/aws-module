resource "aws_vpc" "vpc" {
    for_each = var.ec2-vpc
  cidr_block = each.value.cidr_block
}
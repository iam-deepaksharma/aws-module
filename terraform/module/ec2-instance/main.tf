resource "aws_instance" "aws_ec2" {
    for_each = var.ec2-variable
  ami           = each.value.ami
  instance_type = each.value.instance_type

  tags = {
    Name = each.value.tag
  }
}
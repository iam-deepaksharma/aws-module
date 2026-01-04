#VPC

resource "aws_vpc" "prod-vpc" {
  cidr_block = "10.0.0.0/16"
}

#Subnet

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1b"
}

#Security Group for EC2

resource "aws_security_group" "aws_sg" {
  name   = "aws-sg"
  vpc_id = aws_vpc.prod-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance

resource "aws_instance" "app1" {
  ami             = "ami-0b69ea66ff7391e80" # Amazon Linux 2
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.subnet1.id
  security_groups = [aws_security_group.aws_sg.name]

  tags = { Name = "app1" }
}


resource "aws_lb" "nlb" {
  name               = "prod-nlb"
  load_balancer_type = "network"
  internal           = false
  subnets            = [aws_subnet.subnet1.id]

  tags = {
    name = "prod-nlb"
  }
}

resource "aws_lb_target_group" "nlb_tg" {
  name        = "prod-nlb-tg"
  port        = "80"
  protocol    = "TCP"
  vpc_id      = aws_vpc.prod-vpc.id
  target_type = "instance"

  health_check {
    protocol = "TCP"
    port     = "80"
  }
}

resource "aws_lb_listener" "nlb_listner" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "nlb_attach" {
  target_group_arn = aws_lb_target_group.nlb_tg.arn
  target_id        = aws_instance.app1.id
  port             = 80
}

ec2-tfvars = {
    aws-ec2 = {
        ami = "ami-0abcd1234efgh5678"
        instance_type = "t2.micro"
        tag = "dev-ec2"
    }
}

vpc-tfvars = {
    aws-vpc = {
        cidr_block = "10.0.0.0/16"
    }
}

subnet-tfvars = {
    aws-subnet = {
        cidr_block = "10.0.1.0/24"
        subnet-tag = "dev-subnet"
        vpc-key = "aws-vpc"
    }
}

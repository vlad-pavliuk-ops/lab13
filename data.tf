data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = ["${var.project_name}-vpc"]
  }
}

data "aws_subnet" "public_1" {
  filter {
    name   = "tag:Name"
    values = ["${var.project_name}-public-subnet1"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
}

data "aws_subnet" "public_2" {
  filter {
    name   = "tag:Name"
    values = ["${var.project_name}-public-subnet2"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
}

data "aws_security_group" "ssh" {
  filter {
    name   = "group-name"
    values = ["${var.project_name}-sg-ssh"]
  }

  vpc_id = data.aws_vpc.this.id
}

data "aws_security_group" "http" {
  filter {
    name   = "group-name"
    values = ["${var.project_name}-sg-http"]
  }

  vpc_id = data.aws_vpc.this.id
}

data "aws_security_group" "lb" {
  filter {
    name   = "group-name"
    values = ["${var.project_name}-sg-lb"]
  }

  vpc_id = data.aws_vpc.this.id
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

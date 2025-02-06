
provider "aws" {
  region = "us-east-1"
}

#VPC
resource "aws_vpc" "Vpc_Terraform" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = "true"

  tags = {
    Name = "Vpc_Terraform"
  }
}

#IGW
resource "aws_internet_gateway" "Igw-Terraform" {
  vpc_id = aws_vpc.Vpc_Terraform.id

  tags = {
    Name = "Igw-Terraform"
  }
}

#Subnet
resource "aws_subnet" "Public_Subnet_Terra" {
  vpc_id     = aws_vpc.Vpc_Terraform.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Public_Subnet_Terra"
  }
}


#Route Table
resource "aws_route_table" "Pub-RT-Terra" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Igw-Terraform.id
  }


  tags = {
    Name = "Pub-RT-Terra"
  }
}

#Route Table Association
resource "aws_route_table_association" "Pub-RTA-Terra" {
  subnet_id      = aws_subnet.Public_Subnet_Terra.id
  route_table_id = aws_route_table.Pub-RT-Terra.id
}

#Security Group
resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.Vpc_Terraform.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_all"
  }

}

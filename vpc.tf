resource "aws_vpc" "terra-vpc" {
    cidr_block = "10.1.0.0/16"
    instance_tenancy = "default"
    tags = {
      "Name" = "terra-vpc"
    }
  
}

resource "aws_subnet" "terra-subnet-a" {
    vpc_id = aws_vpc.terra-vpc.id
    availability_zone = "us-east-1a"
    cidr_block = "10.1.9.0/24"
    tags = {
      "Name" = "terra-subnet-a"
    }
  
}

resource "aws_subnet" "terra-subnet-b" {
    vpc_id = aws_vpc.terra-vpc.id
    availability_zone = "us-east-1b"
    cidr_block = "10.1.6.0/24"
    tags = {
      "Name" = "terra-subnet-b"
    }
  
}

resource "aws_internet_gateway" "terra-igw" {
    vpc_id = aws_vpc.terra-vpc.id
    tags = {
      "Name" = "terra-igw"
    }
  
}

resource "aws_route_table" "terra-rt" {
    vpc_id = aws_vpc.terra-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.terra-igw.id
    }
  
}

resource "aws_route_table_association" "terra-rt-ass-a" {
    subnet_id = aws_subnet.terra-subnet-a.id
    route_table_id = aws_route_table.terra-rt.id
  
}

resource "aws_route_table_association" "terra-rt-ass-b" {
    subnet_id = aws_subnet.terra-subnet-b.id
    route_table_id = aws_route_table.terra-rt.id
  
}

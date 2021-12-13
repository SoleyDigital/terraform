

provider "aws" {
    region = "eu-west-2"
}

# Subnet Variable
variable "cidr_blocks" {
    description = "cidr blocks for vpc and subnets"
    type = list(object({
        cidr_block = string
        name = string
    }))
}

variable avail_zone {
  
}
# VPC Variable
variable "vpc_cidr_block" {
  description = "vpc cidr block"
}

variable "environment" {
      description = "deployment environment"

}
resource "aws_vpc" "dev-vpc" {
    cidr_block = var.vpc_cidr_block[0].cidr_block
    tags = {
        Name: var.cidr_blocks[0].name
    }

}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.dev-vpc.id
    cidr_block =  var.cidr_blocks[1].cidr_block
    availability_zone = var.avail_zone
    tags = {
        Name: var.cidr_blocks[1].name
    }
}

output "dev-vpc-id" {
    value = aws_vpc.dev-vpc.id
}

output "dev-subnet-id" {
    value = aws_subnet.dev-subnet-1.id
}
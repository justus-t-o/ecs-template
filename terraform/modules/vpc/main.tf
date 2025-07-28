
resource "aws_vpc" "main" {
  cidr_block = var.cidr
  tags       = { Name = var.name }
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.cidr, 8, 0)
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true
  tags = { Name = "${var.name}-public-a" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = [aws_subnet.public_a.id]
}

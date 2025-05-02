resource "aws_nat_gateway" "nat" {
  connectivity_type = "public"
  allocation_id     = aws_eip.nat_eip.id
  subnet_id         = aws_subnet.public_subnet_a.id

  tags = {
    Name = var.nat_gateway_name
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}
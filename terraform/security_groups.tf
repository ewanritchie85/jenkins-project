# PUBLIC ###########################################

resource "aws_security_group" "public_security_group" {
  name        = var.public_security_group_name
  description = "allows all HTTP ingress, SSH ingress from local machine, and all egress"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = var.public_security_group_name
  }
}
resource "aws_vpc_security_group_ingress_rule" "public_http_in" {
  security_group_id = aws_security_group.public_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  tags = {
  }
}

resource "aws_vpc_security_group_ingress_rule" "public_ssh_in" {
  security_group_id = aws_security_group.public_security_group.id
  cidr_ipv4         = local.my_ip_cidr
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  tags = {
  }
}

resource "aws_vpc_security_group_egress_rule" "public_all_out" {
  security_group_id = aws_security_group.public_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 0
  to_port           = 65535
  ip_protocol       = "tcp"
  tags = {
  }
}

# PRIVATE ####################################################

resource "aws_security_group" "private_security_group" {
  name        = var.private_security_group_name
  description = "allows SSH and HTTP ingress from public subnets, and all egress"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = var.private_security_group_name
  }
}
resource "aws_vpc_security_group_ingress_rule" "private_http_in" {
  security_group_id = aws_security_group.private_security_group.id
  cidr_ipv4         = "10.0.0.0/21"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  tags = {
  }
}

resource "aws_vpc_security_group_ingress_rule" "private_ssh_in" {
  security_group_id = aws_security_group.private_security_group.id
  cidr_ipv4         = "10.0.0.0/21"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  tags = {
  }
}

resource "aws_vpc_security_group_egress_rule" "private_all_out" {
  security_group_id = aws_security_group.private_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 0
  to_port           = 65535
  ip_protocol       = "tcp"
  tags = {
  }
}
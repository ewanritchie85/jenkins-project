resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_security_group.id]
  subnets = [aws_subnet.public_subnet_a.id,
  aws_subnet.public_subnet_b.id]
  enable_deletion_protection = false
  tags = {
  }


}
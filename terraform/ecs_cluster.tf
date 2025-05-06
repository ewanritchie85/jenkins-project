
resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
  tags = {
  }

}

resource "aws_lb_target_group" "alb_target_group" {
  name        = var.alb_target_group_name
  target_type = "ip"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  tags = {
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 3000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
  tags = {
  }
}

resource "aws_ecs_task_definition" "app_task" {
  family                   = "app-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "${var.container_name}"
      image = "${var.docker_image}"
      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ],
      environment = [
        {
          name  = "PORT"
          value = "80"
        },
        {
          name  = "NODE_ENV"
          value = "production"
        }
      ]
    }
  ])
  tags = {
  }
}



resource "aws_ecs_service" "app_service" {
  name            = var.app_service_name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.app_task.arn
  launch_type     = "FARGATE"
  desired_count   = 2

  network_configuration {
    subnets          = [aws_subnet.private_subnet.id]
    security_groups  = [aws_security_group.private_security_group.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.alb_target_group.arn
    container_name   = var.container_name
    container_port   = 80
  }
  tags = {
  }
}


variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "profile" {
  description = "AWS profile"
  type        = string
  default     = "ten10"
}

variable "docker_image" {
  description = "Docker image for the application"
  type        = string
  default     = "654463037626.dkr.ecr.eu-west-2.amazonaws.com/ewan/jenkins-repo:latest"

}

variable "container_name" {
  description = "Container name tag"
  type        = string
  default     = "ewan-site"

}

variable "vpc_name" {
  description = "VPC name tag"
  type        = string
  default     = "ewan-vpc"
}

variable "internet_gateway_name" {
  description = "Internet Gateway name tag"
  type        = string
  default     = "ewan-gateway"
}

variable "public_subnet_name" {
  description = "Public Subnet name tag"
  type        = string
  default     = "ewan-public-subnet"
}
variable "private_subnet_name" {
  description = "Private Subnet name tag"
  type        = string
  default     = "ewan-private-subnet"
}
variable "public_rt_name" {
  description = "Public Route Table name tag"
  type        = string
  default     = "ewan-public-rt"

}

variable "private_rt_name" {
  description = "Private Route Table name tag"
  type        = string
  default     = "ewan-private-rt"
}
variable "public_security_group_name" {
  description = "Public Security Group name tag"
  type        = string
  default     = "ewan-public-sg"

}

variable "private_security_group_name" {
  description = "Private Security Group name tag"
  type        = string
  default     = "ewan-private-sg"

}

variable "ecs_cluster_name" {
  description = "ECS Cluster name tag"
  type        = string
  default     = "ewan-ecs-cluster"

}

variable "alb_target_group_name" {
  description = "ALB Target Group name tag"
  type        = string
  default     = "ewan-alb-tg"

}

variable "ecs_task_execution_role_name" {
  description = "ECS Task Execution Role name tag"
  type        = string
  default     = "ewan-ecs-task-execution-role"

}

variable "alb_name" {
  description = "ALB name tag"
  type        = string
  default     = "ewan-alb"

}



variable "app_service_name" {
  description = "ECS Service name tag"
  type        = string
  default     = "ewan-app-service"

}

variable "nat_gateway_name" {
  description = "NAT gateway name tag"
  type        = string
  default     = "ewan-nat-gateway"

}
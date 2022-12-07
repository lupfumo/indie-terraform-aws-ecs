resource "aws_ecs_cluster" "tfecsimage" {
  name = "tfecsimage-ecs-cluster"
}

resource "aws_ecs_service" "ecs_service" {
  name            = "tfecsimage-service"
  cluster         = aws_ecs_cluster.tfecsimage.id
  task_definition = aws_ecs_task_definition.ecs_tasks.arn
  desired_count   = var.container_count // number of containers 
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.alb-sg.id]
    subnets         = module.vpc.private_subnets
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tg.arn
    container_name   = "tfecsimage"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.alb-listener, aws_iam_role_policy_attachment.ecs_task_execution_role]

  tags = local.common_tags
}


resource "aws_ecs_task_definition" "ecs_tasks" {
  family                   = aws_ecs_cluster.tfecsimage.name
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = var.fargate_cpu    //1024 for this container
  memory                   = var.fargate_memory //2048mb for this container
  requires_compatibilities = ["FARGATE"]
  container_definitions    = data.template_file.tfecsimage-file.rendered
  tags                     = local.common_tags
}
resource "aws_alb" "alb" {
  name            = "${local.name}-alb"
  subnets         = module.vpc.public_subnets
  security_groups = [aws_security_group.alb-sg.id]

  tags = local.common_tags
}

resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = var.port_app
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_lb_target_group" "tg" {
  name        = "${local.name}-alb-targetgrp"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "ip"
  
  health_check {
    healthy_threshold   = "3"
    interval            = "10"
    protocol            = "HTTP"
    matcher             = "200-299"
    timeout             = "5"
    path                = "/"
    unhealthy_threshold = "2"
  }
}

/*
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "6.4.0"

  name               = "${local.name}-alb"
  load_balancer_type = "application"
  vpc_id             = module.vpc.vpc_id
  subnets = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1]
  ]
  security_groups = [module.loadbalancer_sg.this_security_group_id]
  #Listerners
  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

  target_groups = [
    #Target Group for APP-1
    {
      name_prefix          = "app1-"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      } 
      protocol_version = "HTTP1"
      targets = {
        my_app1_vm = {
          target_id = module.ec2_private_instance_app1["one"].id
          port      = 80
        },
        my_app2_vm = {
          target_id = module.ec2_private_instance_app1["two"].id
          port      = 80
        }
      }
      tags = local.common_tags
    },
    #Target Group for APP-2
    {
      name_prefix          = "app2-"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app2/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      targets = {
        my_app2_vm = {
          target_id = module.ec2_private_instance_app2["one"].id
          port      = 80
        },
        my_app2_vm = {
          target_id = module.ec2_private_instance_app2["two"].id
          port      = 80
        }
      }
      tags = local.common_tags
    }
  ]
  #HTTPS Listerners
  https_listeners = [
    # HTTPS Listener Index = 0 for HTTPS 443
    {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = module.acm.acm_certificate_arn
      action_type     = "fixed-response"
      fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed static message - for Root Context"
        status_code  = "200"
      }
    },
  ]
  #HTTPS Listerner rules
  https_listener_rules = [
    # Rule-1: app1* should go to App1 EC2 Instances
    {
      https_listener_index = 0
      priority             = 1
      actions = [
        {
          type               = "forward"
          target_group_index = 0
        }
      ]
      conditions = [{
        //path_patterns = ["/app1*"]
        //host_headers = [var.app1_dns_name]
        http_headers = [{
          http_header_name = "custom-header"
          values           = ["app-1", "app1", "my-app-1"]
        }]
      }]
    },
    # Rule-2: app2* should go to App2 EC2 Instances
    {
      https_listener_index = 0
      priority             = 2
      actions = [
        {
          type               = "forward"
          target_group_index = 1
        }
      ]
      conditions = [{
        //path_patterns = ["/app2*"]
        //host_headers = [var.app2_dns_name]
        http_headers = [{
          http_header_name = "custom-header"
          values           = ["app-2", "app2", "my-app-2"]
        }]
      }]
    },
    # Rule-3: when Query-string, redirect to 
    {
      https_listener_index = 0
      priority             = 3
      actions = [
        {
          type        = "redirect"
          status_code = "HTTP_302"
          host        = "stacksimplify.com"
          path        = "/aws-eks/"
          query       = ""
          protocol    = "HTTP"
        }
      ]
      conditions = [{
        query_string = [{
          key   = "website"
          value = "aws-eks"
        }]
      }]
    }
  ]
  tags = local.common_tags
}
*/
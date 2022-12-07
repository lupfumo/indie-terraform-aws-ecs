data "template_file" "tfecsimage-file" {
  template = file("./image.json.tpl")
  vars = {
    aws_ecr_repository = aws_ecr_repository.repo.repository_url
    tag                = data.aws_ssm_parameter.image_tag.value
    app_port           = var.port_app
    allowed_ports      = aws_alb.alb.dns_name
  }
}

data "aws_ssm_parameter" "image_tag" {
  name = "IMAGE_ECS_STORE"
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "src"
  output_path = "lambda-function-aws.zip"
}


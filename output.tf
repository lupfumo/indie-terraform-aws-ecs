output "alb_hostname" {
  value = aws_alb.alb.dns_name
}

output "latest_image_tag" {
  value = data.aws_ssm_parameter.image_tag.value
}

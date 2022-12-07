[
  {
    "name": "tfecsimage",
    "image": "${aws_ecr_repository}:${tag}",
    "essential": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "af-south-1",
        "awslogs-stream-prefix": "tfecsimage-awslogs-service",
        "awslogs-group": "tfecsimage-awslogs"
      }
    },
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80,
        "protocol": "tcp"
      }
    ],
    "cpu": 1,
    "environment": [
      {
        "name": "IMAGE_TAG",
        "value": "data.aws_ssm_parameter.image_tag.value"
      },
      {
        "name": "PORT",
        "value": "80"
      }
    ],
    "ulimits": [
      {
        "name": "nofile",
        "softLimit": 65536,
        "hardLimit": 65536
      }
    ],
    "mountPoints": [],
    "memory": 2048,
    "volumesFrom": []
  }
]
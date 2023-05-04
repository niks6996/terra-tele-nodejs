resource "aws_ecs_task_definition" "terra-task-demo" {
    family = "terra-task-demo"
    execution_role_arn = aws_iam_role.ecs-task-execution-role.arn
    network_mode = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu = var.fargate-cpu
    memory = var.fargate-memory
    container_definitions = jsonencode([
      {
        name = "nodejstele"
        image = "docker.io/meghraj1996/nodejs-telegram:nodejstele"
        cpu = 1024
        memory = 2048
        portMappings = [
          {
            containerPort = 3020
          }
        ]

      }
    ])
} 

resource "aws_ecs_service" "terra-svc-demo" {
    name = "terra-svc-demo"
    cluster = aws_ecs_cluster.terra-ecs.id
    task_definition = aws_ecs_task_definition.terra-task-demo.id
    desired_count = var.app-count
    launch_type = "FARGATE"
    deployment_minimum_healthy_percent = 0
    deployment_maximum_percent = 200

    network_configuration {
      security_groups = [ aws_security_group.terra-ecs-sg.id]
      subnets = [aws_subnet.terra-subnet-a.id, aws_subnet.terra-subnet-b.id]
      assign_public_ip = true
    }

    load_balancer {
        target_group_arn = aws_lb_target_group.terra-alb-tg.arn
        container_name = "nodejstele"
        container_port = 3020
    }

    depends_on = [aws_lb_listener.terra-alb-list, aws_iam_role_policy_attachment.ecs-task-execution-role]
}

resource "aws_lb" "terra-alb" {
    name = "terra-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.terra-alb-sg.id]
    subnets = [aws_subnet.terra-subnet-a.id, aws_subnet.terra-subnet-b.id]
    tags = {
      "Name" = "terra-alb"
    }  
}

resource "aws_lb_target_group" "terra-alb-tg" {
    name = "terra-alb-tg"
    target_type = "ip"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.terra-vpc.id
    health_check {
      enabled = true
      path = "/"
      protocol = "HTTP"
      healthy_threshold = 5
      unhealthy_threshold = 2
      timeout = 5
      interval = 30
      matcher = 200

    }  
}

resource "aws_lb_listener" "terra-alb-list" {
    load_balancer_arn = aws_lb.terra-alb.arn
    port = 80
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.terra-alb-tg.arn

    } 
}

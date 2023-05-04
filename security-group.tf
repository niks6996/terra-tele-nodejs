resource "aws_security_group" "terra-alb-sg" {
    name = "terra-alb-sg"
    description = "Load Balancer Security Group"
    vpc_id = aws_vpc.terra-vpc.id
    ingress {
        protocol = "tcp"
        from_port = var.app-port
        to_port = var.app-port
        cidr_blocks = ["0.0.0.0/0"]
        
    }

    egress {
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]

    }
    tags = {
      "Name" = "terra-alb-sg"
    }
  
}

resource "aws_security_group" "terra-ecs-sg" {
    name = "terra-ecs-sg"
    description = "allow inbound access from the ALB only"
    vpc_id = aws_vpc.terra-vpc.id
    ingress {
        from_port = var.app-port
        to_port = var.app-port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        security_groups = [aws_security_group.terra-alb-sg.id]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      "Name" = "terra-ecs-sg"
    }
  
}

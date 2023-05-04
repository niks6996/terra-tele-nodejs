variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_Region" {}

variable "ecs-exec-role" {
    default = "myECcsTaskExecutionRole"  
}

variable "fargate-cpu" {
  default     = 1024
  description = "fargate instacne CPU units to provision,my requirent 1 vcpu so gave 1024"
}

variable "fargate-memory" {
  default     = 2048
  description = "Fargate instance memory to provision (in MiB) not MB"
}

variable "cont-app-port" {
  default     = 3020
  description = "portexposed on the docker image"
}

variable "app-port" {
  default     = 80
  description = "portexposed on the docker image"
}

variable "app-image" {
  default     = "docker.io/meghraj1996/nodejs-telegram:nodejstele"
  description = "docker image to run in this ECS cluster"
}

variable "app-count" {
    default = 1
    description = "number of docker container to run"
  
}

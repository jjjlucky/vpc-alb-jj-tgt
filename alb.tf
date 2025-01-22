// create an application load balancer 
resource "aws_lb" "app-lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application" #string
  security_groups    = [aws_security_group.alb-sg1.id]
  subnets            = [aws_subnet.pub-A.id, aws_subnet.pub-B.id]

  enable_deletion_protection = false #boolean

  tags = {
    name = "app-lb"
    env  = "dev"
  }

}

// Create listener for load balancer 
resource "aws_lb_listener" "lb-http-listener" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg.arn
  }

}

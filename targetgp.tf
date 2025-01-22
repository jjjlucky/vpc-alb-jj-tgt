// Create a target group 
resource "aws_lb_target_group" "alb-tg" {
  name     = "alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.alb-vpc.id
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 100
    matcher             = 200
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 6
    unhealthy_threshold = 3
  }

}

// create target group attachment 
resource "aws_lb_target_group_attachment" "attach-1" {
  target_group_arn = aws_lb_target_group.alb-tg.arn
  target_id        = aws_instance.Ec2-A.id
  port             = 80

}
resource "aws_lb_target_group_attachment" "attach-2" {
  target_group_arn = aws_lb_target_group.alb-tg.arn
  target_id        = aws_instance.Ec2-B.id
  port             = 80
}

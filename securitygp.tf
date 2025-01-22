//create security-Group for load balancer
resource "aws_security_group" "alb-sg1" {
  name        = "alb-sg1"
  vpc_id      = aws_vpc.alb-vpc.id
  description = "allow http and https"
  tags = {
    team = "dev"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


//create security group for webserver 
resource "aws_security_group" "webserver-sg2" {
  name        = "webserver-sg2"
  vpc_id      = aws_vpc.alb-vpc.id
  description = "allow 80 to alb-sg"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg1.id]
    #cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

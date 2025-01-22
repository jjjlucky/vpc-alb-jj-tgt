// create EC2 instance for private subnet A
resource "aws_instance" "Ec2-A" {
  #associate_public_ip_address = false
  ami                         = "ami-045269a1f5c90a6a0"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private-A.id
  vpc_security_group_ids             = [aws_security_group.webserver-sg2.id]
  user_data                   = file("code.sh")
   tags = {
     name = "webserver-A"
   }
}
   

// Create Ec2 instance for private subnet B
resource "aws_instance" "Ec2-B" {
  #associate_public_ip_address = false
  ami                         = "ami-0454e52560c7f5c55"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private-B.id
  vpc_security_group_ids           = [aws_security_group.webserver-sg2.id]
  user_data                   = file("code.sh")
  tags = {
     name = "webserver-B"
   }
}

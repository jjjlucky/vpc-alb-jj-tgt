
resource "aws_instance" "web" {
  ami                                  = "ami-0c614dee691cbbf37"
  associate_public_ip_address          = true
  availability_zone                    = "us-east-1a"
  instance_type                        = "t2.micro"
  key_name                             = "windowserverkey"
  monitoring                           = false
  security_groups                      = ["launch-wizard-4"]
  subnet_id                            = "subnet-02d0b626754963d6e"
  tags = {
    Name = "terraform-import"
  }
  vpc_security_group_ids      = ["sg-0e271ff026d2320c4"]
}

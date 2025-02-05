provider "aws" {
    region = "us-east-1"
  
}

import {
  to = aws_instance.web
  id = "i-0898e7a31e65f0a1a"
}


provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "angular_app" {
  ami           = "ami-01f23391a59163da9" 
  instance_type = "t2.medium"
  key_name      = "webapp-keypair" # Create this in AWS

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "AngularAppEC2"
  }
}

resource "aws_security_group" "web_sg" {
  name_prefix = "angular-web-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    from_port   = 4200
    to_port     = 4200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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

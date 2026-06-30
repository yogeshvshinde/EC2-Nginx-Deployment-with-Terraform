#########################################
# AWS Provider
#########################################

provider "aws" {
  region = var.region
}

#########################################
# Get Default VPC
#########################################

data "aws_vpc" "default" {
  default = true
}

#########################################
# Security Group
#########################################

resource "aws_security_group" "nginx_sg" {

  name        = "terraform-nginx-sg"
  description = "Allow SSH and HTTP access"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Terraform-Nginx-SG"
  }
}

#########################################
# Ubuntu Server 24.04 LTS ( As 20.0 LTS is not available)
#########################################

resource "aws_instance" "nginx_server" {

  ami           = "ami-006f82a1d5a27da54"
  instance_type = var.instance_type

  subnet_id = "subnet-0d904a2448e696bfc"

  vpc_security_group_ids = [
    aws_security_group.nginx_sg.id
  ]

  user_data = <<-EOF
              #!/bin/bash

              apt-get update -y

              apt-get install nginx -y

              cat > /var/www/html/index.html <<HTML
              <html>
              <head>
                  <title>Terraform Nginx Server</title>
              </head>
              <body>
                  <h1>Welcome to the Terraform-managed Nginx Server on Ubuntu</h1>
              </body>
              </html>
              HTML

              systemctl enable nginx
              systemctl start nginx
              EOF

  tags = {
    Name = "Terraform-Nginx-Server"
  }
}
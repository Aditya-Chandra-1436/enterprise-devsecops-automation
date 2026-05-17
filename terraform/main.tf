resource "aws_key_pair" "deploy_key" {
  key_name   = "enterprise-devsecops-key"
  public_key = file("keys/id_rsa.pub")
}

resource "aws_security_group" "deploy_sg" {

  name = "enterprise-devsecops-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3002
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

resource "aws_instance" "devsecops_server" {

  ami                    = "ami-04f167a56786e4b09"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.deploy_key.key_name
  vpc_security_group_ids = [aws_security_group.deploy_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install docker.io -y
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ubuntu
              EOF

  tags = {
    Name = "Enterprise-DevSecOps-Deployment"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "sg_windows_nueva" {
  name        = "sg_windows_terraform_nueva"
  description = "Security Group para instancia Windows"
  vpc_id      = "vpc-0122b2d4ff694cb1f"

  # Permitir RDP únicamente desde tu IP pública exacta
  ingress {
    description = "Acceso RDP desde mi IP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["45.162.72.65/32"]
  }

  # Salida completa hacia Internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "Instancia_Windows_Terraform" {
  ami                    = "ami-0b5f645abc199e666" 
  instance_type          = "t3.micro"              
  key_name               = "mi-segunda-llaves-ja"  
  vpc_security_group_ids = [aws_security_group.sg_windows_nueva.id] 

  tags = {
    Name = "InstanciaWindowsTerraform" 
  }
}
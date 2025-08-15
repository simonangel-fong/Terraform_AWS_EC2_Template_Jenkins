resource "aws_instance" "ec2_instace" {
  ami           = var.aws_ec2_ami
  instance_type = var.instance_type

  # network
  subnet_id              = aws_subnet.main_subnet_public.id
  vpc_security_group_ids = [aws_security_group.sg_ssh_http.id]
  key_name               = var.aws_key

  tags = {
    Name = "ec2_instace"
  }

}

resource "aws_security_group" "sg_ssh_http" {
  name   = "sg_ssh_http"
  vpc_id = aws_vpc.vpc_main.id

  # inbound: ssh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # inbound: http
  ingress {
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
}

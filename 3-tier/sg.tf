# security group to be attached to ec2 instance
resource "aws_security_group" "3-tier-kpmg-security-group" {
  name        = "3-tier Guilherme Security Group"
  description = "3-tier Guilherme Security Group"

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${ aws_vpc.vpc_kpmg.id }"
}
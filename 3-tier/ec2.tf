# creating new keypair in EC2
resource "aws_key_pair" "authentication" {
  key_name   = "${ var.key_name }"
  public_key = "${ file(var.public_key_path) }"
}

resource "aws_instance" "3-tier-kpng" {
  ami = ""

  instance_type = "${ var.instance_type }"
  key_name      = "${ var.key_name }"

  source_dest_check           = false
  subnet_id                   = "${ aws_subnet.public_subnet.id }" 
  associate_public_ip_address = true                               

  vpc_security_group_ids = ["${ aws_security_group.3-tier-kpmg-security-group.id }"] # attaching security group

}
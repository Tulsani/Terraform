# ************************
# vars.tf
# ************************
 
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "eu-central-1"
}
variable "AMIS" {
  type = "map"
  default = {
    # *******************************************
    # https://cloud-images.ubuntu.com/locator/ec2/
    #
    #   Frankfurt => eu-central-1
    #   OS        => UBUNTU Xenial 16.04 LTS
    #   AMI_ID    => ami-245f7fcf
    #
    #   AMI shortcut (AMAZON MACHINE IMAGE)
    # helps select the image we want to spin up
    # *******************************************
    eu-central-1 = "ami-415b7baa"
  }
}
 
# ************************
# provider.tf
# ************************
provider "aws" {
    access_key = "${var.AWS_ACCESS_KEY}"
    secret_key = "${var.AWS_SECRET_KEY}"
    region = "${var.AWS_REGION}"
}
 
 
# ************************
# instance.tf
# ************************
resource "aws_instance" "TULSANI_new_instance" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  tags = { Name = "UDEMY" }
  instance_type = "t2.micro"
  provisioner "local-exec" {
     command = "echo ${aws_instance.TULSANI_new_instance.private_ip} >> private_ips.txt"
  }
}
output "ip" {
    value = "${aws_instance.TULSANI_new_instance.public_ip}"
}
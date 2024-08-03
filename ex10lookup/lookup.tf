provider "aws" {
    access_key = var.accesskey
    secret_key = var.secretkey
    region = var.reg
}
resource "aws_instance" "awsins"{
    count = "${var.env == "dev"?1:0}"
    ami = "${lookup(var.amis,var.reg)}"
    instance_type = "${var.env == "deg"?"t2.nano":"t2.micro"}"
    key_name = "vpc-NAT"

}
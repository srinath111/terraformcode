provider "aws" {
    region = var.reg
    access_key = var.accesskey
    secret_key = var.secretkey
}
resource "aws_instance" "awsins"{
    count = "${var.env == "prod"?2:0}"
    ami = "${lookup(var.amis,var.reg)}"
    instance_type = "${var.env == "deg"?"t2.nano":"t2.micro"}"
    key_name = "vpc-NAT"

}
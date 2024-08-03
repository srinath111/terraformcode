provider "aws"{
    region = "us-east-1"
    access_key = ""
    secret_key = ""
}
resource "aws_security_group" "AWSSG"{
    name = "srinathk"
    ingress{
       from_port=433
       to_port = 433
       protocol = "tcp"
       cidr_blocks = [var.vpn_id]
    }
    ingress{
       from_port=80
       protocol = "http"
       to_port = 80
       cidr_blocks = [var.vpn_id]
        }
    ingress{
       from_port=53
       to_port = 53
       protocol = "tcp"
       cidr_blocks = [var.vpn_id]
    }

}
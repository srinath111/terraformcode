provider "aws"{
    region ="us-east-1"
    access_key = ""
    secret_key = ""
}
resource "aws_instance" "name"{
    ami= var.awsami
    instance_type = var.instancetype
    tags = {
        Name="srin"
    }
}
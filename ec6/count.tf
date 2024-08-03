provider "aws"{
    region = "us-east-1"
    access_key = ""
    secret_key = ""
}
resource "aws_instance" "awsi"{
    count=2
    tags ={
        Name = "sri"
    }
    ami= "ami-0e731c8a588258d0d"
    instance_type = "t2.micro"
}
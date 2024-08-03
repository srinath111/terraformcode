provider "aws"{
    region = "us-east-1"
    access_key = ""
    secret_key = ""
}
resource "aws_instance" "awsi"{
    count=3
    tags ={
        Name = "sri.${count.index}"
    }
    ami= "ami-0e731c8a588258d0d"
    instance_type = "t2.micro"
}
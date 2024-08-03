provider "aws" {
    region = "us-east-1"
    access_key = ""
    secret_key = ""
}
resource "aws_iam_user" "sr"{
    name = var.srinathl
     path = "/system/"
     tags = {
        Name= "srim"
     }

}
resource "aws_iam_access_key" "lb" {
  user = var.srk
}
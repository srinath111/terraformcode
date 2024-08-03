variable "publicsub"{
    type = list
    default = ["us-east-1a","us-east-1b","us-east-1c"]
}
variable "publiccidr" {
    type = list
    default = ["10.1.1.0/24","10.1.2.0/24","10.1.3.0/24"]
}
variable "privatesub" {
    type = list
    default = ["us-east-1e","us-east-1f"]
}
variable "privatecidr" {
    type = list
    default = ["10.1.10.0/24","10.1.20.0/24"]
}
variable "srisub"{
    default = "10.1.0.0/16"
}
#variable "accesskey"{
 #    default = ""
#}
#variable "secretkey"{
 #   default = ""
#}
#variable "reg"{
 #   default = "us-east-1"
#}
#variable "instance"{
#   default = "ami-0e731c8a588258d0d"
#}
#variable "type"{
   #default = "t2.micro"
#}
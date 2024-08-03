variable "accesskey"{
    default = ""
}
variable "secretkey"{
    default = ""
}
variable "reg"{
    default = "us-east-1"
}
#variable "hk"{}
variable "env"{
    default = "dev"
}
variable "amis"{
    type = map
    default = {
        us-east-1 = "ami-0440d3b780d96b29d"
        us-east-2 = "ami-02ca28e7c7b8f8be1"
    }
}


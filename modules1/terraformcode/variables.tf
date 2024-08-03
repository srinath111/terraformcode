variable "vpc"{
    default = "172.1.0.0/16"
}
variable "publicregion1"{
    default = "us-east-1a"
}
variable "publiccidr1"{
    default = "172.1.1.0/24"
}
variable "publicregion2"{
    default = "us-east-1b"
}
variable "publiccidr2"{
    default = "172.1.2.0/24"
}
variable "taginternetgateway"{
    default = "IG_1"
}
variable "tagpublicsubnet2"{
    default = "public subnet2"
}
variable "tagpublicsubnet1"{
    default = "public subnet1"
}
variable "tagvpcname"{
    default = "vpc1"
}
variable "tagsecgroup"{
    default = "SG1"
}
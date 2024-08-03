variable "accesskey"{
     default = ""
}
variable "secretkey"{
    default = ""
}
variable "publicaz"{
    type = list
    default = ["us-east-1a","us-east-1b","us-east-1c"]
}
variable "publicsub" { 
    type = list
    default = ["10.1.1.0/24","10.1.2.0/24","10.1.3.0/24"]
}
variable "privateaz"{
    type = list
    default = ["us-east-1d","us-east-1e","us-east-1f"]
}
variable "privatesub" { 
    type = list
    default = ["10.1.10.0/24","10.1.20.0/24","10.1.30.0/24"]
}
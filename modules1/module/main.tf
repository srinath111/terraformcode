provider "aws"{
    access_key = ""
    secret_key = ""
    region = "us-east-1"
}

module "vpc1"{
    source = "../../modules1/terraformcode"
    #source = "../terraformcode"
    #source = "./terraformcode"
    #  . -> dot indicates current working directory
    vpc = "172.3.0.0/16"
    publicregion1 = "us-east-1a"
    publiccidr1 = "172.3.1.0/24"
publicregion2 = "us-east-1b"
publiccidr2 = "172.3.2.0/24"
taginternetgateway = "IG_1"
tagpublicsubnet2 = "public subnet2"
tagpublicsubnet1 = "public subnet1"
tagvpcname = "vpc1"
tagsecgroup = "SG1" 
}

resource "aws_instance" "instance" {
  ami = "ami-0440d3b780d96b29d"
  instance_type = "t2.micro"
  key_name = "sr"
  subnet_id = "${module.vpc1.publicsubnet1}"
  vpc_security_group_ids = ["${module.vpc1.sg_id}"]
  associate_public_ip_address = true
  tags = {
      Name = "srinath"
     }   
  }


output "publicsubnet1"{
    value = "${module.vpc1.publicsubnet1}"
}
output "publicsubnet2"{
    value = "${module.vpc1.publicsubnet2}"
}
output "securitygroup"{
    value = "${module.vpc1.sg_id}"
}

provider "aws"{
    access_key = ""
    secret_key = ""
    region = "us-east-1"
}

module "vpc1"{
    source = "../../modules/terraformcode"
    srisub = "${var.srisub}"
    publicsub= "${var.publicsub}"
    publiccidr= "${var.publiccidr}"
    privatesub = "${var.privatesub}"
    privatecidr = "${var.privatecidr}"
    }
module "vpc2"{
    srisub = "10.3.0.0/16"
    source = "../../modules/terraformcode"
    publicsub= ["us-east-1a","us-east-1b","us-east-1c"]
    publiccidr= ["10.3.11.0/24","10.3.12.0/24","10.3.13.0/24"]
    privatesub = ["us-east-1e","us-east-1f"]
    privatecidr = ["10.3.10.0/24","10.3.20.0/24"]
    }
 #   module "vpc3"{
  #  source = "../../modules/terraformcode"
   # publicsub= "${var.publicsub}"
    #publiccidr= "${var.publiccidr}"
    #privatesub = "${var.privatesub}"
    #privatecidr = "${var.privatecidr}"
    #}

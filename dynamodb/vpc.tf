provider "aws"{
   access_key = ""
   secret_key = ""
   region = ""
}
resource "aws_vpc" "vpccr"{
  cidr_block = "${var.vpc}"
  tags={
	name = "sr"
    Name = "${var.tagvpcname}"
  }
}
resource "aws_subnet" "subnet1"{
  vpc_id = "${aws_vpc.vpccr.id}"
  tags={
    Name = "${var.tagpublicsubnet1}"
  }
  availability_zone = "${var.publicregion1}"
  cidr_block = "${var.publiccidr1}"
}
resource "aws_subnet" "subnet2"{
  vpc_id = "${aws_vpc.vpccr.id}"
  tags={
    Name = "${var.tagpublicsubnet2}"
  }
  availability_zone = "${var.publicregion2}"
  cidr_block = "${var.publiccidr2}"
}
resource "aws_internet_gateway" "gw"{
  vpc_id = "${aws_vpc.vpccr.id}"
  tags={
    Name = "${var.taginternetgateway}"
  }
}
resource "aws_route_table" "table"{
  vpc_id = "${aws_vpc.vpccr.id}"
  tags = {
    Name = "route-main-table"
  }
}
resource "aws_route_table_association" "subnetas1"{
  subnet_id = "${aws_subnet.subnet1.id}"
  route_table_id = "${aws_route_table.table.id}"
}
resource "aws_route_table_association" "subnetas2"{
  subnet_id = "${aws_subnet.subnet2.id}"
  route_table_id = "${aws_route_table.table.id}"
}
resource "aws_route" "p"{
  route_table_id            = "${aws_route_table.table.id}"
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = "${aws_internet_gateway.gw.id}"
}
resource "aws_security_group" "SG"{
  name = "${var.tagsecgroup}"
  description = "haiSG"
  vpc_id  = "${aws_vpc.vpccr.id}"
  tags = {
    Name = "secSG"
  }
  ingress{
      from_port   = 0
      protocol = "-1"
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
      from_port   = 0
      protocol = "-1"
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
  }
}
output "publicsubnet1"{
  value = "${aws_subnet.subnet1.id}"
}
output "publicsubnet2"{
  value = "${aws_subnet.subnet2.id}"
}
output "sg_id"{
  value = "${aws_security_group.SG.id}"
}
terraform {
 backend "s3"{
   bucket = "srinathk1"
   key = "workspace.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraformlock"
    encrypt = true
  }
}
resource "aws_dynamodb_table" "terraform_locks"{
  name = "terraformlock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

provider "aws"{
    access_key = var.accesskey
    secret_key = var.secretkey
    region = var.reg
}
resource "aws_vpc" "vpccr"{
  cidr_block = "172.1.0.0/16"
  tags={
    Name = "red-vpc"
  }
}
resource "aws_subnet" "subnet1"{
  vpc_id = "${aws_vpc.vpccr.id}"
  tags={
    Name = "public1"
  }
  availability_zone = "us-east-1a"
  cidr_block = "172.1.1.0/24"
}
resource "aws_subnet" "subnet2"{
  vpc_id = "${aws_vpc.vpccr.id}"
  tags={
    Name = "public2"
  }
  availability_zone = "us-east-1b"
  cidr_block = "172.1.2.0/24"
}
resource "aws_internet_gateway" "gw"{
  vpc_id = "${aws_vpc.vpccr.id}"
  tags={
    Name = "AWS_IGW"
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
  name = "secgroup"
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

 
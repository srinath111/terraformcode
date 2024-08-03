provider "aws" {
    region = "us-east-1"
    access_key = var.accesskey
    secret_key = var.secretkey
}

resource "aws_vpc" "awsvpc"{
    cidr_block = "10.1.0.0/16"
    tags    ={    Name = "srinathvpc"}
    }
resource "aws_subnet" "public1sub"{
    count = "${length(var.publicaz)}"
    vpc_id = "${aws_vpc.awsvpc.id}"
    availability_zone = "${element(var.publicaz,count.index)}"
    cidr_block= "${element(var.publicsub,count.index)}"
    tags={
        Name = "publicsub-${count.index + 1}"
    }
    depends_on = [aws_internet_gateway.int]
}
resource "aws_subnet" "privatesub1"{
    count = "${length(var.privateaz)}"
    vpc_id = "${aws_vpc.awsvpc.id}"
    availability_zone = "${element(var.privateaz,count.index)}"
    cidr_block= "${element(var.privatesub,count.index)}"
    tags={
        Name = "privatesub-${(count.index + 1)}"
    }
}
resource "aws_route_table" "publicrt"{
    vpc_id = "${aws_vpc.awsvpc.id}"
    tags={
    Name = "publicroute"
    }
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.int.id}"
    }
}
resource "aws_route_table" "privatecrt"{
    vpc_id = "${aws_vpc.awsvpc.id}"
    tags={
    Name = "privateroute"
    }
}
resource "aws_internet_gateway" "int"{
    vpc_id = "${aws_vpc.awsvpc.id}"
    tags = {
        Name = "INTGW"
    }
}
resource "aws_route_table_association" "terraform-public"{
    count = "${length(var.publicaz)}"
    subnet_id = "${element(aws_subnet.public1sub.*.id,count.index)}"
    route_table_id = "${aws_route_table.publicrt.id}"
}
resource "aws_route_table_association" "terraform-private"{
    count = "${length(var.privateaz)}"
    subnet_id = "${element(aws_subnet.privatesub1.*.id,count.index)}"
    route_table_id = "${aws_route_table.privatecrt.id}"
}
resource "aws_security_group" "SG"{
  name = "secgroup"
  description = "haiSG"
  vpc_id  = "${aws_vpc.awsvpc.id}"
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
resource "aws_eip" "awseip"{
    # eip elastic ip address
}
resource "aws_nat_gateway" "awsnat"{
    allocation_id = aws_eip.awseip.id
    subnet_id     = aws_subnet.public1sub.1.id
}
resource "aws_route" "awsroute"{
    route_table_id = "${aws_route_table.privatecrt.id}"
    destination_cidr_block    = "0.0.0.0/0"
    gateway_id                = "${aws_nat_gateway.awsnat.id}"
}
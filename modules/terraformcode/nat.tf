#provider "aws"{
 #   access_key = var.accesskey
  #  secret_key = var.secretkey
   # region = var.reg
#}
resource "aws_vpc" "sri" {
    cidr_block = "${var.srisub}"
    tags = {
        Name = "srivpc"
    }
}
resource "aws_subnet" "publicsubnet" {
    count = "${length(var.publicsub)}"
    # length = length is used to count the length of the list 
    vpc_id = "${aws_vpc.sri.id}"
    availability_zone = "${element(var.publicsub,count.index)}"
    # element = retrives single element from the list 
    cidr_block = "${element(var.publiccidr,count.index)}"
    tags = {
        Name = "publicsubnet-${count.index + 1}"
    }
    depends_on = [aws_internet_gateway.ING]
}
resource "aws_subnet" "privatesubnet" {
    count = "${length(var.privatesub)}"
    vpc_id = "${aws_vpc.sri.id}"
    availability_zone = "${element(var.privatesub,count.index)}"
    cidr_block = "${element(var.privatecidr,count.index)}"
    tags = {
        Name = "privatesubnet-${count.index + 1}"
    }
}
resource "aws_security_group" "awsSG"{
    vpc_id = "${aws_vpc.sri.id}"
    tags = {
        Name = "awsSG"
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
resource "aws_route_table" "publicroute"{
    vpc_id = "${aws_vpc.sri.id}"
    tags = {
        Name = "public subnet"
    }
}
resource "aws_route_table" "privateroute"{
    vpc_id = "${aws_vpc.sri.id}"
    tags = {
        Name = "private subnet"
    }
}
resource "aws_route_table_association" "publicass"{
count = "${length(var.publicsub)}"
subnet_id = "${element(aws_subnet.publicsubnet.*.id,count.index)}"
# splat = splat expression allows us to get list of all the attributes
route_table_id = "${aws_route_table.publicroute.id}"
}
resource "aws_route_table_association" "privateass"{
count = "${length(var.privatesub)}"
subnet_id = "${element(aws_subnet.privatesubnet.*.id,count.index)}"
route_table_id = "${aws_route_table.privateroute.id}"
}
resource "aws_internet_gateway" "ING"{
    vpc_id = "${aws_vpc.sri.id}"
    tags = {
        Name = "ING1"
    }
}
resource "aws_route" "internetconection" {
    route_table_id = "${aws_route_table.publicroute.id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ING.id}"
}
resource "aws_eip" "publicip"{
    # AWs_eip reserved public ip address
}
resource "aws_nat_gateway" "awsnat" {
  allocation_id = aws_eip.publicip.id
  subnet_id     = aws_subnet.publicsubnet.1.id

  tags = {
    Name = "gw NAT"
  }
}
resource "aws_route" "privateroute"{
    
    route_table_id = "${aws_route_table.privateroute.id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.awsnat.id}"
}
#resource "aws_instance" "instance"{
   # count = "${length(var.publicsub)}"
 #   ami = var.instance
  #  instance_type = var.type
    #key_name = "vpc-NAT"
   # key_name = "sr"
    #vpc_id = "${aws_vpc.sri.id}"
    #subnet_id = "${element(aws_subnet.publicsubnet.*.id,count.index)}"
    #associate_public_ip_address = true
    #vpc_security_group_ids = [aws_security_group.awsSG.id]

#}
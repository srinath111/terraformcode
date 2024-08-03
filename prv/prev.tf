provider "aws"{
    access_key = " "
    secret_key = ""
    region = "us-east-1"
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
resource "aws_instance" "instance" {
    ami = "ami-0440d3b780d96b29d"
    instance_type = "t2.micro"
     key_name = "srinath"
     subnet_id = aws_subnet.subnet2.id
     vpc_security_group_ids = ["aws_security_group.SG.id"]
     associate_public_ip_address = true
     tags = {
      Name = "srinath"
     }
        
  }

  resource "null_resource" "namel"{
   connection {
           type = "ssh"
           user = "ec2-user"
           private_key = file("./srinath.pem")
          host = "${aws_instance.instance.public_ip}"
       }
  #provisioner "remote-exec" {
   # inline = [
     #   "sudo yum update -y",
      #  "sudo yum install -y nginx",
        #"sudo systemctl start nginx",
        #"chmod +x /tmp/script.sh",
        #"sudo bash /tmp/script.sh"
    #]
 # }
  provisioner "file"{
    source = "script.sh"
    destination  = "/tmp/script.sh"
  }
#provisioner "local_exec"{
 # command = <<EOH
  #echo "{aws_instance.instance.public.ip "} >> details && echo "{aws_instance.instance.private.ip "} >> details,
  #EOH
#}

 }

 
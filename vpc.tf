#VPC

resource "aws_vpc" "vpcmain" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpcmain"
  }
}

#SUBNET

resource "aws_subnet" "awsmain" {
  vpc_id     = "${aws_vpc.vpcmain.id}"
  cidr_block = "192.168.0.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1a"


  tags = {
    Name = "subnet"
  }
}

#INTERNET_GATEWAY

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpcmain.id}"

  tags = {
    Name = "gateway"
  }
}
resource "aws_route_table" "route" {
  vpc_id = "${aws_vpc.vpcmain.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "route-table"
  }
}
resource "aws_route_table_association" "first" {
  subnet_id      = aws_subnet.awsmain.id
  route_table_id = aws_route_table.route.id
}

#creating NAT getway
resource "aws_eip" "myeip" {
  instance = aws_instance.webserver.id
  vpc = true
}

#resource "aws_eip" "myeip2" {
#  instance = aws_instance.webserver2.id
#  vpc = true
#}


#resource "aws_eip" "myeip3" {
#  instance = aws_instance.webserver3.id
#  vpc = true
#}

#resource "aws_eip" "myeiph" {
#  instance = aws_instance.haproxy.id
#  vpc = true
#}
#resource "aws_nat_gateway" "mynatg" {
#  allocation_id = aws_eip.myeip.id
#  subnet_id = "${aws_subnet.awsmain.id}"
#  depends_on = [aws_internet_gateway.gw]
#
#  tags = {
#   Name = "ntag"
# }
#}

#resource "aws_eip_association" "eip_assoc" {
#  instance_id   = aws_instance.webserver.id
#  allocation_id = aws_eip.myeip.id
#  depends_on = [aws_instance.webserver]
#}

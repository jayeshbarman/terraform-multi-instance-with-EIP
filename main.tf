#WEBSERVER_INSTANCE

resource "aws_instance" "webserver" {
 
  ami = "ami-006d3995d3a6b963b"
  #count = 4
  instance_type = "t2.micro"
  key_name = "task"
  subnet_id = aws_subnet.awsmain.id
  associate_public_ip_address = true
  vpc_security_group_ids = [ aws_security_group.sg1.id ]

  tags = {
    Name = "webserver-os"
  }
}
resource "null_resource" "nullremote1" {
  depends_on = [aws_eip.myeip, aws_instance.webserver ]
  connection {
    type = "ssh"
    user= "ubuntu"
    private_key = file("/home/ubuntu/task.pem")
    host = aws_eip.myeip.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install git  -y"
    ]
  }
}

# Instance 2

resource "aws_instance" "webserver2" {

  ami = "ami-006d3995d3a6b963b"
  #count = 4
  instance_type = "t2.micro"
  key_name = "task"
  subnet_id = aws_subnet.awsmain.id
  associate_public_ip_address = true
  vpc_security_group_ids = [ aws_security_group.sg1.id ]

  tags = {
    Name = "webserver-os2"
  }
}
resource "null_resource" "nullremote2" {
  depends_on = [aws_eip.myeip2, aws_instance.webserver2 ]
  connection {
    type = "ssh"
    user= "ubuntu"
    private_key = file("/home/ubuntu/task.pem")
    host = aws_eip.myeip2.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install git  -y"
    ]
  }
}

# Instance 3

resource "aws_instance" "webserver3" {

  ami = "ami-006d3995d3a6b963b"
  #count = 4
  instance_type = "t2.micro"
  key_name = "task"
  subnet_id = aws_subnet.awsmain.id
  associate_public_ip_address = true
  vpc_security_group_ids = [ aws_security_group.sg1.id ]

  tags = {
    Name = "webserver-os3"
  }
}
resource "null_resource" "nullremote3" {
  depends_on = [aws_eip.myeip3, aws_instance.webserver3 ]
  connection {
    type = "ssh"
    user= "ubuntu"
    private_key = file("/home/ubuntu/task.pem")
    host = aws_eip.myeip3.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install git  -y"
    ]
  }
}


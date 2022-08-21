#WEBSERVER_INSTANCE

resource "aws_instance" "webserver" {
 
  ami = "ami-006d3995d3a6b963b"
  instance_type = "t2.micro"
  key_name = "task"
  subnet_id = aws_subnet.awsmain.id
  private_ip = "192.168.0.10"
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
  provisioner "file" {
    source      = "/root/terraform_code/haproxy.cfg"
    destination = "/tmp/haproxy.cfg"
  }
  provisioner "file" {
    source      = "/root/terraform_code/keepalived1/keepalived.sh"
    destination = "/tmp/keepalived.sh"
  }
 #provisioner "file" {
 #  source      = "/root/terraform_code/check_apiserver.sh"
 #  destination = "/tmp/check_apiserver.sh"
 #}
 provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get upgrade -y",
      "sudo apt-get update -y",
      "sudo apt install git apache2 haproxy keepalived curl unzip -y",
      "sudo curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip'",
      "sudo unzip awscliv2.zip",
      "sudo ./aws/install",
      "sudo systemctl start apache2",
      "sudo mv /tmp/haproxy.cfg /etc/haproxy/haproxy.cfg",
      "echo ${aws_eip.myeip.public_ip}",
      "echo ${aws_instance.webserver.id}",
      "sudo chmod +x /tmp/keepalived.sh",
     # "sudo chmod +x /tmp/check_apiserver.sh",
      "sudo /tmp/keepalived.sh ${aws_eip.myeip.public_ip} ${aws_instance.webserver.id}",
     # "sudo /tmp/check_apiserver.sh ${aws_eip.myeip.public_ip}",
      "sudo chmod +x /etc/keepalived/check_apiserver.sh",
      "sudo systemctl restart haproxy",
      "sudo systemctl restart keepalived",
      "sudo systemctl enable haproxy",
      "sudo systemctl enable keepalived",
      "sudo systemctl enable iscsid"
    ]
  }
}

# Instance 2

resource "aws_instance" "webserver2" {

  ami = "ami-006d3995d3a6b963b"
  instance_type = "t2.micro"
  key_name = "task"
  subnet_id = aws_subnet.awsmain.id
  private_ip = "192.168.0.20"
  associate_public_ip_address = true
  vpc_security_group_ids = [ aws_security_group.sg1.id ]

  tags = {
    Name = "webserver-os2"
  }
}
resource "null_resource" "nullremote2" {
  depends_on = [aws_eip.myeip, aws_instance.webserver2 ]
  connection {
    type = "ssh"
    user= "ubuntu"
    private_key = file("/home/ubuntu/task.pem")
    host = aws_instance.webserver2.public_ip
  }
  provisioner "file" {
    source      = "/root/terraform_code/haproxy.cfg"
    destination = "/tmp/haproxy.cfg"
  }
  provisioner "file" {
    source      = "/root/terraform_code/keepalived2/keepalived.sh"
    destination = "/tmp/keepalived.sh"
  }
 #provisioner "file" {
 #  source      = "/root/terraform_code/check_apiserver.sh"
 #  destination = "/tmp/check_apiserver.sh"
 #}
 provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get upgrade -y",
      "sudo apt-get update -y",
      "sudo apt install git apache2 haproxy keepalived curl unzip -y",
      "sudo curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip'",
      "sudo unzip awscliv2.zip",
      "sudo ./aws/install",
      "sudo systemctl start apache2",
      "sudo mv /tmp/haproxy.cfg /etc/haproxy/haproxy.cfg",
      "echo ${aws_eip.myeip.public_ip}",
      "echo ${aws_instance.webserver2.id}",
      "sudo chmod +x /tmp/keepalived.sh",
  #    "sudo chmod +x /tmp/check_apiserver.sh",
      "sudo /tmp/keepalived.sh ${aws_eip.myeip.public_ip} ${aws_instance.webserver2.id}",
  #    "sudo /tmp/check_apiserver.sh ${aws_eip.myeip.public_ip}",
      "sudo chmod +x /etc/keepalived/check_apiserver.sh",
      "sudo systemctl restart haproxy",
      "sudo systemctl restart keepalived",
      "sudo systemctl enable haproxy",
      "sudo systemctl enable keepalived",
      "sudo systemctl enable iscsid"
    ]
  }
}

# Instance 3

resource "aws_instance" "webserver3" {

  ami = "ami-006d3995d3a6b963b"
  instance_type = "t2.micro"
  key_name = "task"
  subnet_id = aws_subnet.awsmain.id
  private_ip = "192.168.0.30"
  associate_public_ip_address = true
  vpc_security_group_ids = [ aws_security_group.sg1.id ]

  tags = {
    Name = "webserver-os3"
  }
}
resource "null_resource" "nullremote3" {
  depends_on = [aws_eip.myeip, aws_instance.webserver3 ]
  connection {
    type = "ssh"
    user= "ubuntu"
    private_key = file("/home/ubuntu/task.pem")
    host = aws_instance.webserver3.public_ip
  }
  provisioner "file" {
    source      = "/root/terraform_code/haproxy.cfg"
    destination = "/tmp/haproxy.cfg"
  }
  provisioner "file" {
    source      = "/root/terraform_code/keepalived3/keepalived.sh"
    destination = "/tmp/keepalived.sh"
  }
 #provisioner "file" {
 #  source      = "/root/terraform_code/check_apiserver.sh"
 #  destination = "/tmp/check_apiserver.sh"
 #}
 provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get upgrade -y",
      "sudo apt-get update -y",
      "sudo apt install git apache2 haproxy keepalived curl unzip -y",
      "sudo curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip'",
      "sudo unzip awscliv2.zip",
      "sudo ./aws/install",
      "sudo systemctl start apache2",
      "sudo mv /tmp/haproxy.cfg /etc/haproxy/haproxy.cfg",
      "echo ${aws_eip.myeip.public_ip}",
      "echo ${aws_instance.webserver3.id}",
      "sudo chmod +x /tmp/keepalived.sh",
  #    "sudo chmod +x /tmp/check_apiserver.sh",
      "sudo /tmp/keepalived.sh ${aws_eip.myeip.public_ip} ${aws_instance.webserver3.id}",
  #    "sudo /tmp/check_apiserver.sh ${aws_eip.myeip.public_ip}",
      "sudo chmod /etc/keepalived/check_apiserver.sh",
      "sudo systemctl restart haproxy",
      "sudo systemctl restart keepalived",
      "sudo systemctl enable haproxy",
      "sudo systemctl enable keepalived",
      "sudo systemctl enable iscsid"
    ]
  }
}

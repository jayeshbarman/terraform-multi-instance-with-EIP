variable "ami" {
    description = "Contains a Amazon Machine Image ID"
    type = string
    default = "ami-006d3995d3a6b963b"
}

variable "instance_type" {
    description = "Contains a Amazon Machine Image ID"
    type = string  
    default = "t2.micro"
}

variable "key" {
    description = "Contains a Amazon Machine Image ID"
    type = string  
    default = "/home/ubuntu/task.pem"
}



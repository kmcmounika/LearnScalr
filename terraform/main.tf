# creating EC2 instance with Key and SG
resource "aws_instance" "servers"{
    count=1
    ami = var.ami_id
     instance_type = var.size
    vpc_security_group_ids = ["servers_sg"]
    tags = {
        Name = local.EC2_Name_Tag
    }
}

# creating SG to attach EC2 instance
resource "aws_security_group" "servers_sg" {
   name        = "scalr_SG"
   description = "security group for Scalar"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # outbound from jenkis server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   tags = {
    Name = "Allow All Traffic"
  }
}


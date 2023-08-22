# creating EC2 instance with Key and SG
resource "aws_instance" "servers"{
    count=1
    ami = var.ami_id
     instance_type = "t2.micro"
      key_name= var.size
    vpc_security_group_ids = ["servers_sg"]
    tags = {
        Name = local.EC2_Name_Tag
    }
}

# creating SG to attach EC2 instance
resource "aws_security_group" "servers_sg" {
   name        = "security_jenkins_port"
   description = "security group for jenkins"

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

# in cmd prompt we need to use below command to generate keys
# ssh-keygen -t rsa
resource "aws_key_pair" "deployer" {
  key_name   = "key1"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDPnphevR6Zhv6P7tMDbfbhC/U930UlgFyIs1JFRmlXNi8LfZZZivakpNy0UhHfXcdICsmcL3YBVSri6M1erdwAi3J/gdwhS5tWshY3zdTXVh2owE8q05UyrqYkLHfPMoJbbWWig2LOJFP9awkzigxpHAo8VAaMKStIWdkUPlp+ZdsBVRoNZZsARkWW7ISEaLe/+VAxfJs0ggicdlQyqENMZX/3M6ug9AkEMb2uzcBXqmJbS8HN8hwYX6QWmXrGMuAUl4NyDF8pWnvXM7bncnH59q/Auhd+HF8ufNJe32O3vmzfbnCPWNJvC8XCrslT+vrms7zZQwGTWHyMujacvzhHi2DDL6fk4upHJiHEcmIvFcbA3KKvUMmqP3e/k9TlJCX7sZeypWRha0wBMSALYgyL7P1DzXaZdFv60NTBgsLaaAKP6HQuzYH+60EcqUzYj7zeIr7Gys7oCYC5kg0LTkSv77AWlSPRboYOv6NP73mKeH2cPXi8OgMvZiW8LU0iT7c= kmcmo@DESKTOP-LBUPGDC"
}


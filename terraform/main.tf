# creating EC2 instance with Key and SG
resource "aws_instance" "servers"{
    count=1
    ami = var.ami_id
     instance_type = var.size
   
    tags = {
        Name = local.EC2_Name_Tag
    }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "ekswork"
  ami = data.aws_ami.centos.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.eks-sg.id]
  subnet_id              = "subnet-07ddcb377209fc64b"
  user_data = file("workstation.sh")
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# sg group 

resource "aws_security_group" "eks-sg" {
  name        = "sg_eks"
  description = "Allow all sg for eks"
  
  ingress {
   description = "HTTPS ingress"
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }

egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }

  tags = {
    Name = "allow_sg"
  }
}


data "aws_ami" "centos" {
  owners  = ["973714476881"]

  filter {
    name   = "name"
    values = ["Centos-8-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
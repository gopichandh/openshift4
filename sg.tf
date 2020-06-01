resource "aws_security_group" "private_ec2_api" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"
}


resource "aws_security_group_rule" "private_ec2_ingress" {
  type        = "ingress"

  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = [
     var.private_vpc_cidr
  ]

  security_group_id =  aws_security_group.private_ec2_api.id
}

resource "aws_security_group_rule" "private_ec2_api_egress" {
  type        = "egress"

  from_port   = 0
  to_port     = 0
  protocol    = "all"
  cidr_blocks = [
    "0.0.0.0/0"
  ]

  security_group_id =  aws_security_group.private_ec2_api.id
}

  /*ingress {
    description = "TLS from VPC, incoming traffic"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = aws_vpc.main.cidr_block
  }

  ingress {
    description = "TLS from VPC, external communication"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = aws_vpc.main.cidr_block
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Clustername = "antman"
    Name = "ocpops"
  }
 
} */

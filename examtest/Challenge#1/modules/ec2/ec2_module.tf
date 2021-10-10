#############################################################
# data sources to get vpc, subnet
#############################################################
data "aws_route53_zone" "selected" {
  name         = "${var.zone}."
  private_zone = true
}

data "aws_subnet" "selected" {
  id = "${var.ec2_subnet_id}"
}

##########################################
# Create Ec2 instance
#########################################

resource "aws_instance" "web" {
  count = "length ${var.ec2_instnce_count}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  key_name = "${var.ec2_key}"
  subnet_id = "${var.ec2_subnet_id}"
  monitoring = "${var.monitoring}"
  vpc_security_group_ids = [aws_security_group.ec2_instance.id]

  tags = {
    Name = "Web-ec2-instance"
    monitoring          = "9100,9308",
  }
}

#######################################
# Create Security group
#########################################
resource "aws_security_group" "ec2_instance" {
  name              = "${var.name}"
  description       = "Security group for ec2-instance service"
  vpc_id            = data.aws_subnet.selected.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  ingress {
    from_port       = 8
    to_port         = 0
    protocol        = "icmp"
    description     = "ping"
    cidr_blocks     = var.access_cidr
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    description     = "ssh"
    cidr_blocks     = var.access_cidr
  }

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    description     = "db_instance_port"
    cidr_blocks     = var.access_cidr
  }

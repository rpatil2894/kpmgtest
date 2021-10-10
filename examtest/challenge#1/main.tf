######################################################
####################  Datas ##########################
######################################################

data "aws_route53_zone" "selected" {
  name         = "${var.zone_name}."
  private_zone = true
}

data "aws_subnet" "selected" {
  id = "${var.subnet_id}"
}


module "web_instance" {
  source = "/module/ec2"
  name                   = var.name
  key_name               = var.ec2_key
  subnet_id              = var.subnet_id
  access_cidr            = var.access_cidr
  instance_type       = var.instance_type
}

#############################################
## RDS Db configuration
############################################
resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = ${var.rds_count}
  identifier         = "aurora-cluster-demo-${count.index}"
  cluster_identifier = aws_rds_cluster.default.id
  instance_class     = "${var.rds_instance_type}"
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
}

resource "aws_rds_cluster" "ec2_rds" {
  cluster_identifier = "aurora-cluster-demo"
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
  database_name      = "mydb"
  master_username    = "root"
  master_password    = "${var.db_pass}"
}


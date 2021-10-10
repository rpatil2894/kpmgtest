###############################################
# Common Variables
###############################################
variable "zone" {
  type = string
}

variable "name" {
  type = string
}
variable "key_name" {
  type = string
}
variable "tags" {
  type = map(string)
}
variable "monitoring" {
  type = string
  default = "false"
}
variable "ec2_subnet_id" {
  type = string
  default = "false"
}

variable "instnace_type" {
  type = string
  default = "t2.micro"
}

variable "ec2_subnet_id" {
type = "string"
}

variable "access_cidr" {
  type = "string"
}


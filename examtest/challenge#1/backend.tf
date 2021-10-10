terraform {
  backend "s3" {
    bucket = "myteststatefile"
    key    = "test/terraform.tfstate"
    region = "us-east-1"
  }
}


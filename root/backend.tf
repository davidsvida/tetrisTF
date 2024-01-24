terraform {
  backend "s3" {
    bucket = "tetrisstatestorage"
    key    = "tetrisdemo.tfstate"
    region = "us-east-1"
    dynamodb_table = "newtfTable"
  }
}
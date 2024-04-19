locals {
  subnet_tags = {
    Name = "${var.name}-subnet"
    ENV = var.env
    PROJECT = "roboshop"

  }
}
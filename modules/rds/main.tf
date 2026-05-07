resource "aws_db_parameter_group" "main" {
  name = "wmp-${var.env}"
  family = "postgres16"
}

resource "aws_db_subnet_group" "main" {
  name       = "wmp-${var.env}"
  subnet_ids = var.db_subnets

  tags = {
    Name = "wmp-${var.env}"
  }
}

resource "aws_db_instance" "main" {
  allocated_storage    = var.allocated_storage
  db_name              = "default-dummy"
  engine               = "postgres"
  engine_version       = "16.3"
  instance_class       = "db.t3.micro"
  username             = "wmpuser"
  password             = "WmpUser#1234"
  parameter_group_name = aws_db_parameter_group.main.name
  skip_final_snapshot  = true
  identifier = "wmp-${var.env}"
}

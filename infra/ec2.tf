resource "aws_instance" "api1" {
  ami = "ami-426cd343"
  availability_zone = "${var.public_segment1_az}"
  instance_type = "${var.ec2_inst}"
  key_name = "ssh-key"
  subnet_id = "${aws_subnet.techlog_vpc-public-subnet1.id}"
  vpc_security_group_ids = [
    "${aws_security_group.app_sg.id}"
  ]
  associate_public_ip_address = "true"
  tags = {
    Name = "Api Server 1"
  }
}

# resource "aws_instance" "api2" {
#   ami = "ami-426cd343"
#   availability_zone = "${var.public_segment2_az}"
#   instance_type = "${var.ec2_inst}"
#   key_name = "ssh-key"
#   subnet_id = "${aws_subnet.techlog_vpc-public-subnet2.id}"
#   vpc_security_group_ids = [
#     "${aws_security_group.app_sg.id}"
#   ]
#   associate_public_ip_address = "true"
#   tags = {
#     Name = "Api Server 2"
#   }
# }

resource "aws_db_instance" "master" {
  identifier = "dbinstance"
  allocated_storage = 5
  engine = "postgres"
  engine_version = "11.5"
  instance_class = "db.t2.micro"
  storage_type = "gp2"
  username = "${var.db_username}"
  password = "${var.db_password}"
  # publicly_accessible = true
  backup_retention_period = 1
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
  db_subnet_group_name = "${aws_db_subnet_group.db.name}"
  tags = {
    Name = "master-db"
  }
}

# resource "aws_db_instance" "slave" {
#   identifier = "dbinstance"
#   allocated_storage = 5
#   engine = "postgres"
#   engine_version = "11.5"
#   instance_class = "db.t2.micro"
#   storage_type = "gp2"
#   username = "${var.db_username}"
#   password = "${var.db_password}"
#   # publicly_accessible = true
#   backup_retention_period = 1
#   vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
#   db_subnet_group_name = "${aws_db_subnet_group.db.name}"
#   tags = {
#     Name = "slave-db"
#   }
# }
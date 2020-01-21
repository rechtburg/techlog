# RDS
resource "aws_db_subnet_group" "default" {
  name = "${var.app_name} rds subnet"
  description = "${var.app_name} MultiAZ Master-Slave"
  subnet_ids = ["${aws_subnet.techlog_vpc-private-subnet1.id}", "${aws_subnet.techlog_vpc-private-subnet2.id}"]
}

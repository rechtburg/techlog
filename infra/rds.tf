# RDS
resource "aws_db_subnet_group" "db" {
  name = "${var.app_name} rds subnet"
  description = "${var.app_name} MultiAZ Master-Slave"
  subnet_ids = ["${aws_subnet.techlog_vpc-private-subnet1.id}"]
  # subnet_ids = ["${aws_subnet.techlog_vpc-private-subnet1.id}", "${aws_subnet.techlog_vpc-private-subnet2.id}"]
  tags = {
    Name = "db_subnet"
  }
}

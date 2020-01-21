# Security Group
resource "aws_security_group" "elb_sg" {
  name = "elb_sq"
  vpc_id = "${aws_vpc.techlog_vpc.id}"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  description = "ELB Security Group"
}

resource "aws_security_group" "app_sg" {
  name = "app_sg"
  vpc_id = "${aws_vpc.techlog_vpc.id}"
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    security_groups = ["${aws_security_group.elb_sg.id}"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  description = "APP Security Group"
}

resource "aws_security_group" "rds_sg" {
  name = "rds_sg"
  vpc_id = "${aws_vpc.techlog_vpc.id}"
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = ["${aws_security_group.app_sg.id}"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  description = "RDS Security Group"
}

  resource "aws_security_group" "kafka-zookeeper-cluster" {
  vpc_id = "${aws_vpc.kafka-vpc.id}"
  name = "kafka-cluster"
  description = "security group for kafka and zookeeper"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 2888
      to_port = 2888
      protocol = "tcp"
      cidr_blocks = ["10.10.0.0/16"]
  }


  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["10.10.0.0/16", "219.75.96.155/32", "0.0.0.0/0"]
  }

  ingress {
      from_port = 3888
      to_port = 3888
      protocol = "tcp"
      cidr_blocks = ["10.10.0.0/16"]
  }

  ingress {
      from_port = 2181
      to_port = 2181
      protocol = "tcp"
      cidr_blocks = ["10.10.0.0/16"]
  }

  ingress {
      from_port = 9092
      to_port = 9092
      protocol = "tcp"
      cidr_blocks = ["10.10.0.0/16"]
  }

  tags {
    Name = "kafka-zookeeper-cluster"
  }
}

resource "aws_security_group" "kafka-utils" {
  vpc_id = "${aws_vpc.kafka-vpc.id}"
  name = "kafka-utils"
  description = "security group for kafka utils"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8001
    to_port = 8001
    protocol = "tcp"
    cidr_blocks = ["10.10.0.0/16"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["10.10.0.0/16"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["10.10.0.0/16", "219.75.96.155/32", "0.0.0.0/0"]
  }

  ingress {
    from_port = 9000
    to_port = 9000
    protocol = "tcp"
    cidr_blocks = ["10.10.0.0/16"]
  }

  ingress {
    from_port = 2181
    to_port = 2181
    protocol = "tcp"
    cidr_blocks = ["10.10.0.0/16"]
  }

  tags {
    Name = "kafka utils security group"
  }
}

# VPC
resource "aws_vpc" "kafka-vpc" {
    cidr_block = "10.10.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags {
        Name = "main"
    }
}

# Subnets
resource "aws_subnet" "kafka-private-1" {
    vpc_id = "${aws_vpc.kafka-vpc.id}"
    cidr_block = "10.10.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1a"

    tags {
        Name = "kafka-private-1"
    }
}

resource "aws_subnet" "kafka-private-2" {
    vpc_id = "${aws_vpc.kafka-vpc.id}"
    cidr_block = "10.10.5.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1b"

    tags {
        Name = "kafka-private-2"
    }
}

resource "aws_subnet" "kafka-private-3" {
    vpc_id = "${aws_vpc.kafka-vpc.id}"
    cidr_block = "10.10.6.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1c"

    tags {
        Name = "kafka-private-3"
    }
}

# Gateway
resource "aws_internet_gateway" "kafka-gateway" {
  vpc_id = "${aws_vpc.kafka-vpc.id}"
  tags {
    Name = "kafka-gateway"
  }
}

# Route table
resource "aws_route_table" "route-table-kafka" {
  vpc_id = "${aws_vpc.kafka-vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.kafka-gateway.id}"
  }
  tags {
    Name = "kafka-route-table"
  }
}

# Subnet assotation
resource "aws_route_table_association" "subnet-1-association" {
  subnet_id      = "${aws_subnet.kafka-private-1.id}"
  route_table_id = "${aws_route_table.route-table-kafka.id}"
}

resource "aws_route_table_association" "subnet-2-association" {
  subnet_id      = "${aws_subnet.kafka-private-2.id}"
  route_table_id = "${aws_route_table.route-table-kafka.id}"
}

resource "aws_route_table_association" "subnet-3-association" {
  subnet_id      = "${aws_subnet.kafka-private-3.id}"
  route_table_id = "${aws_route_table.route-table-kafka.id}"
}

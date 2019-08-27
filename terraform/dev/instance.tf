# Zookeeper kafka server #1

resource "aws_instance" "kafka1" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.small"

  # the VPC subnet
  subnet_id = "${aws_subnet.kafka-private-1.id}"

  private_ip = "10.10.4.9"
  associate_public_ip_address = true

  # the security group
  vpc_security_group_ids = ["${aws_security_group.kafka-zookeeper-cluster.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"
  tags {
      Name = "Kafka Zookeeper 1"
  }

  # Copies the ebs volume script to kafka home
  provisioner "file" {
    source      = "${var.SRC_PATH_SETTINGS_TAR}"
    destination = "${var.DEST_PATH_SETTINGS_TAR}"
  }

  provisioner "remote-exec" {
    inline = [
      "tar -xvf ${var.DEST_PATH_SETTINGS_TAR} -C ${var.DEST_SETTINGS_EXTRACT_PATH}",
      "chmod +x ${var.DEST_PATH_TO_CLUSTER_SETUP_SH}",
    ]
  }

  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}

resource "aws_instance" "kafka2" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.small"

  # the VPC subnet
  subnet_id = "${aws_subnet.kafka-private-2.id}"

  private_ip = "10.10.5.9"
  associate_public_ip_address = true

  # the security group
  vpc_security_group_ids = ["${aws_security_group.kafka-zookeeper-cluster.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"
  tags {
    Name = "Kafka Zookeeper 2"
  }

  # Copies the ebs volume script to kafka home
  provisioner "file" {
    source      = "${var.SRC_PATH_SETTINGS_TAR}"
    destination = "${var.DEST_PATH_SETTINGS_TAR}"
  }

  provisioner "remote-exec" {
    inline = [
      "tar -xvf ${var.DEST_PATH_SETTINGS_TAR} -C ${var.DEST_SETTINGS_EXTRACT_PATH}",
      "chmod +x ${var.DEST_PATH_TO_CLUSTER_SETUP_SH}",
    ]
  }

  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}

resource "aws_instance" "kafka3" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.small"

  # the VPC subnet
  subnet_id = "${aws_subnet.kafka-private-3.id}"

  private_ip = "10.10.6.9"
  associate_public_ip_address = true

  # the security group
  vpc_security_group_ids = ["${aws_security_group.kafka-zookeeper-cluster.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"
  tags {
    Name = "Kafka Zookeeper 3"
  }

  # Copies the ebs volume script to kafka home
  provisioner "file" {
    source      = "${var.SRC_PATH_SETTINGS_TAR}"
    destination = "${var.DEST_PATH_SETTINGS_TAR}"
  }

  provisioner "remote-exec" {
    inline = [
      "tar -xvf ${var.DEST_PATH_SETTINGS_TAR} -C ${var.DEST_SETTINGS_EXTRACT_PATH}",
      "chmod +x ${var.DEST_PATH_TO_CLUSTER_SETUP_SH}",
    ]
  }

  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}

# ebs volume attached to EC2 kafka1
resource "aws_ebs_volume" "ebs-vol-kafka1" {
    availability_zone = "us-east-1a"
    size = 2
    type = "gp2"
    tags {
        Name = "Volume for server kafka1"
    }
}

# ebs volume attached to EC2 kafka2
resource "aws_ebs_volume" "ebs-vol-kafka2" {
    availability_zone = "us-east-1b"
    size = 2
    type = "gp2"
    tags {
        Name = "Volume for server kafka3"
    }
}

# ebs volume attached to EC2 kafka3
resource "aws_ebs_volume" "ebs-vol-kafka3" {
    availability_zone = "us-east-1c"
    size = 2
    type = "gp2"
    tags {
        Name = "Volume for server kafka3"
    }
}

# attach volume to EC2 kafka2
resource "aws_volume_attachment" "ebs-vol-kafka1-attachment" {
  device_name = "/dev/xvdh"
  volume_id = "${aws_ebs_volume.ebs-vol-kafka1.id}"
  instance_id = "${aws_instance.kafka1.id}"
}

resource "aws_volume_attachment" "ebs-vol-kafka2-attachment" {
  device_name = "/dev/xvdh"
  volume_id = "${aws_ebs_volume.ebs-vol-kafka2.id}"
  instance_id = "${aws_instance.kafka2.id}"
}

resource "aws_volume_attachment" "ebs-vol-kafka3-attachment" {
  device_name = "/dev/xvdh"
  volume_id = "${aws_ebs_volume.ebs-vol-kafka3.id}"
  instance_id = "${aws_instance.kafka3.id}"
}

# Utils
resource "aws_instance" "kafka-utils" {
  ami           = "${lookup(var.PUBLIC_AMIS, var.AWS_REGION)}"
  instance_type = "t2.small"

  # the VPC subnet
  subnet_id = "${aws_subnet.kafka-private-1.id}"

  associate_public_ip_address = true

  # the security group
  vpc_security_group_ids = ["${aws_security_group.kafka-utils.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"
  tags {
    Name = "Kafka Utils"
  }

  # Copies the ebs volume script to kafka home
  provisioner "file" {
    source      = "${var.SRC_PATH_TOOLS_TAR}"
    destination = "${var.DEST_PATH_TOOLS_TAR}"
  }

  provisioner "remote-exec" {
    inline = [
      "tar -xvf ${var.DEST_PATH_TOOLS_TAR} -C ${var.DEST_TOOLS_EXTRACT_PATH}",
      "chmod +x ${var.DEST_PATH_TOOLS_SETUP_SH}",
      "${var.DEST_PATH_TOOLS_SETUP_SH}"
    ]
  }

  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}

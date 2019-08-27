variable "AWS_ACCESS_KEY" {
  default = "AKIA2BYNCMIVWSE7KKWH"
}
variable "AWS_SECRET_KEY" {
  default = "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"
}
variable "AWS_REGION" {
  default = "us-east-1"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykafkakey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykafkakey.pub"
}

variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-001ce97055605d36e"
  }
}
variable "PUBLIC_AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-0a313d6098716f372"
  }
}
variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}
variable "SRC_PATH_SETTINGS_TAR" {
  default = "../../dev/settings.tar"
}
variable "DEST_PATH_SETTINGS_TAR" {
  default = "/home/ubuntu/settings.tar"
}
variable "DEST_SETTINGS_EXTRACT_PATH" {
  default = "/home/ubuntu/"
}
variable "SRC_PATH_TO_CLUSTER_SETUP_SH" {
  default = "../../dev/cluster-setup.sh"
}
variable "DEST_PATH_TO_CLUSTER_SETUP_SH" {
  default = "/home/ubuntu/settings/cluster-setup.sh"
}

variable "SRC_PATH_TOOLS_TAR" {
  default = "../../dev/tools.tar"
}
variable "DEST_PATH_TOOLS_TAR" {
  default = "/home/ubuntu/tools.tar"
}

variable "DEST_TOOLS_EXTRACT_PATH" {
  default = "/home/ubuntu/"
}
variable "DEST_PATH_TOOLS_SETUP_SH" {
  default = "/home/ubuntu/tools/setup.sh"
}
variable "ZOONAVIGATOR_SETUP_SH" {
  default = "/home/ubuntu/tools/zoonavigator-setup.sh"
}
variable "KAFKAMANAGER_SETUP_SH" {
  default = "/home/ubuntu/tools/kafka-manager-setup.sh"
}






terraform {
  required_providers {
    tencentcloud = {
      source = "tencentcloudstack/tencentcloud"
    }
  }
}

# Configure the TencentCloud Provider
provider "tencentcloud" {
  region = "ap-hongkong"
}

# vm 实例
resource "tencentcloud_instance" "proto" {
  instance_name              = "proto"
  availability_zone          = "ap-hongkong-2"
  image_id                   = "img-487zeit5"
  instance_type              = "GN7.2XLARGE32"
  system_disk_type           = "CLOUD_PREMIUM"
  system_disk_size           = 50
  allocate_public_ip         = true
  internet_max_bandwidth_out = 100
  orderly_security_groups    = [tencentcloud_security_group.proto.id]
  count                      = 1

  instance_charge_type = "SPOTPAID"
  hostname = "proto"
  key_ids = [
    "skey-n85dbrjp"
  ]
}

# 安全组
resource "tencentcloud_security_group" "proto" {
  name        = "web accessibility"
  description = "make it accessible for both production and stage ports"
}

# 安全策略规则
resource "tencentcloud_security_group_lite_rule" "simple_test" {
  security_group_id = tencentcloud_security_group.proto.id
  ingress = [
    "ACCEPT#0.0.0.0/0#80#TCP",
    "ACCEPT#0.0.0.0/0#443#TCP",
    "ACCEPT#0.0.0.0/0#22#TCP",
  ]

  egress = [
    "ACCEPT#0.0.0.0/0#ALL#ALL",
  ]
}





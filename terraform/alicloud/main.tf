provider "alicloud" {
  region = "ap-southeast-1" # 新加坡
}

data "alicloud_images" "default" {
  name_regex = "^ubuntu_[0-9]+_[0-9]+_x64*"
  owners     = "system"
}

# 专用网络
resource "alicloud_vpc" "vpc" {
  vpc_name   = "vpc_default"
  cidr_block = "172.16.0.0/12"
}

# 交换机
resource "alicloud_vswitch" "vsw" {
  vpc_id     = alicloud_vpc.vpc.id
  cidr_block = "172.16.0.0/21"
  zone_id    = "ap-southeast-1a"
}

# 默认安全组
resource "alicloud_security_group" "default" {
  name   = "default"
  vpc_id = alicloud_vpc.vpc.id
}

# 安全组规则
resource "alicloud_security_group_rule" "allow_all_tcp" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "1/65535"
  priority          = 1
  security_group_id = alicloud_security_group.default.id
  cidr_ip           = "0.0.0.0/0"
}

# ip 地址，基于流量计费
resource "alicloud_eip" "eip" {
  bandwidth            = "100"
  internet_charge_type = "PayByTraffic"
}

# vm - 抢占
resource "alicloud_instance" "simple_test" {
  security_groups = alicloud_security_group.default.*.id

  instance_type        = "ecs.gn6i-c8g1.2xlarge"
  system_disk_category = "cloud_efficiency"
  system_disk_size     = 60
  image_id             = "m-t4n30t27gpbgu8vnjnav"
  # image_id             = "m-t4nex5nus27q6vj90j4o"
  # image_id             = "ubuntu_22_04_x64_20G_alibase_20230815.vhd"

  instance_name = "chat-proto"
  vswitch_id    = alicloud_vswitch.vsw.id
  key_name      = "marshal"

  instance_charge_type = "PostPaid"
  spot_strategy        = "SpotAsPriceGo"
}

# ip 关联 vm
resource "alicloud_eip_association" "eip_asso" {
  allocation_id = alicloud_eip.eip.id
  instance_id   = alicloud_instance.simple_test.id
}
output "public_ip" {
  value = data.tencentcloud_eips.kn_default_eip.eip_list.0.public_ip
}

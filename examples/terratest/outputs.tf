output "nlb_eip_url" {
  value = module.nlb-eip.nlb_dns_name
}

output "nlb_noeip_url" {
  value = module.nlb-noeip.nlb_dns_name
}

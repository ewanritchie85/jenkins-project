data "http" "my_ip" {
  url = "https://ipv4.icanhazip.com"
}

locals {
  my_ip_cidr = "${trimspace(data.http.my_ip.response_body)}/32"
}
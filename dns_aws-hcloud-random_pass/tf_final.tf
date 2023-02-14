#-------------------------------------------------#
#                                                 #
# Create aws record zone with IP for every VPS    #
# hcloud_server. Generation random password then  #
# change password for root.                       #
#                                                 #
#-------------------------------------------------#

variable "hcloud_token" {}
variable "ssh_key_my" {}
variable "ssh_key_rebrain" {}
variable "access_key_aws" {}
variable "secret_key_aws" {}

variable "instance" {
  type = map
  default = {
    "node1" = 0
    "node2" = 1
  }
}

variable "devs" {
  type = map
  default = {
    "node1" = "welcome-news"
    "node2" = "welcome-news"
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_ssh_key" "my_ssh_key" {
  name       = "My id_rsa"
  public_key = var.ssh_key_my
}

resource "hcloud_ssh_key" "default" {
  name       = "Pub_key_rebrain"
  public_key = var.ssh_key_rebrain
}

resource "random_password" "password" {
  count            = 2
  length           = 8
  special          = true
  override_special = "_%@"
}

resource "hcloud_server" "node" {
  for_each    = var.instance
  name        = "welcome-news-${each.value}"
  image       = "ubuntu-18.04"
  server_type = "cx11"
  ssh_keys    = [hcloud_ssh_key.default.id, hcloud_ssh_key.my_ssh_key.id]
  labels      = { "module" : "devops", "email" : "welcome-news_at_mail_ru" }

  provisioner "remote-exec" {
    inline = [
      "bash -c 'echo -e \"random_password.password[${each.value}].result\nrandom_password.password[${each.value}].result\" | passwd root'"
    ]
  }
}

output "password" {
  value = random_password.password[0].result
}

output "password1" {
  value = random_password.password[1].result
}

provider "aws" {
  access_key = var.access_key_aws
  secret_key = var.secret_key_aws
  region     = "us-east-1"
}

resource "aws_route53_zone" "primary" {
  name = "devops.rebrain.srwx.net"
}

resource "aws_route53_record" "www1" {
  count   = length(var.devs)
  zone_id = aws_route53_zone.primary.zone_id
  name = "${element(values(var.devs), count.index)}-${element(keys(var.devs),
  count.index)}.${aws_route53_zone.primary.name}"
  type = "A"
  ttl  = "300"
  # records = ["element(keys(hcloud_server.(var.devs)).ipv4_address, count.index)"]
  records = ["element(hcloud_server.node.*.ipv4_address, count.index)"]

  provisioner "local-exec" {
    command = "echo ${count.index}: ${self.name} ${self.records} ${random_password.
    password[count.index].result} >> info.txt"
  }

  depends_on = [hcloud_server.node]
}

#---------------------------#
#    Lesson terraform-03    #
# Created by Ignatov Sergey #
#---------------------------#
# variable "do_token" {}

variable "do_token_rebrain" {}
variable "ssh_key_my" {}

resource "digitalocean_tag" "devops_tag" {
  name = "devops"
}

resource "digitalocean_tag" "email_tag" {
  name = "welcome-news_at_mail_ru"
}

resource "digitalocean_ssh_key" "default" {
  name       = "My id_rsa"
  public_key = var.ssh_key_my
}

provider "digitalocean" {
  token = var.do_token_rebrain
}

data "external" "getssh_key" {
  program = ["/bin/bash", "${path.root}/../getssh_key.sh"]
}

resource "digitalocean_ssh_key" "rebrain_ssh" {
  name       = "REBRAIN_SSH_PUB_KEY"
  public_key = data.external.getssh_key.result["REBRAIN.SSH.PUB.KEY"]
}

resource "digitalocean_droplet" "terra4" {
  image  = "ubuntu-18-04-x64"
  name   = "terraform-lesss-02"
  region = "nyc2"
  size   = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.rebrain_ssh.fingerprint,
  digitalocean_ssh_key.default.fingerprint]
  tags = [digitalocean_tag.devops_tag.id,
  digitalocean_tag.email_tag.id]
}

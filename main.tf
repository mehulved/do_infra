#Configure cloudflare provider
provider "cloudflare" {
  email              = "${var.cloudflare_email}"
  token              = "${var.cloudflare_token}"
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token              = "${var.do_token}"
}

module "instance" {
  source             = "git::git@github.com:mehulved/digitalocean_cloudflare_module_terraform.git?ref=v0.0.3"

  domain             = "${var.cloudflare_domain}"
  instance_name      = "web"
  instance_region    = "${var.instance_region}"
  instance_size      = "${var.instance_size}"
  ssh_keyname        = "T440p SSD"
  ssh_keypath        = "${file("${path.root}/ssh-keys/mehul.pub")}"
}

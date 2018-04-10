# Set the variable value in *.tfvars file
# or using -var="var_name=..." CLI option
variable "do_token" {}
variable "cloudflare_email" {}
variable "cloudflare_token" {}
variable "cloudflare_domain" {}

#Configure cloudflare provider
provider "cloudflare" {
  email              = "${var.cloudflare_email}"
  token              = "${var.cloudflare_token}"
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token              = "${var.do_token}"
}

# Upload ssh key
resource "digitalocean_ssh_key" "default" {
  name               = "T400p SSD"
  public_key         = "${file("ssh-keys/mehul.pub")}"
}

# Create a web server
resource "digitalocean_droplet" "web" {
  image              = "freebsd-11-1-x64-zfs"
  name               = "web.mehulved.com"
  region             = "nyc3"
  size               = "1gb"
  backups            = false
  monitoring         = false
  ipv6               = true
  private_networking = true
  ssh_keys           = ["${digitalocean_ssh_key.default.id}"]
  resize_disk        = true
}

# Set DNS record to point to the web server
resource "cloudflare_record" "web" {
  domain             = "${var.cloudflare_domain}"
  name               = "web"
  value              = "${digitalocean_droplet.web.ipv4_address}"
  type               = "A"
  ttl                = 3600
  proxied            = false
}

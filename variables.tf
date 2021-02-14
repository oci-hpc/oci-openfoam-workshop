# variable "tenancy_ocid" {}
# variable "user_ocid" {}
# variable "fingerprint" {}
# variable "private_key_path" {}
variable "region" {}
variable "compartment_ocid" {}
variable "ssh_public_key" {}
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}
data "oci_identity_regions" "available_regions" {
  filter {
    name = "name"
    values = [var.region]
    regex = false
  }
}
output "block_volumes_and_device_paths" {
  value = zipmap(oci_core_volume.bv.*.display_name,
      oci_core_volume_attachment.bv_attachment.*.device)
}
output "bv_attachment_info" {
  value = ["ls -l /dev/oracleoci/", "cat /home/opc/iscsi-commands.sh"]
}
output "mount_commands" {
  value = "cat /home/opc/mount-commands.sh"
}
output "ping_info" {
  value = "ping ${oci_core_instance.compute.public_ip}"
}
output "ssh_info" {
  value = ["ssh opc@${oci_core_instance.compute.public_ip} # if private ssh key is in default location, ~/.ssh/id_rsa", "ssh -i <private ssh key path> opc@${oci_core_instance.compute.public_ip}"]
}
variable "compute_shape" { default = "VM.Standard2.1" }
variable "ad_number" { default = 1 }
locals {
  # network values
  vcn_cidr = "10.1.0.0/23"
  pub_sub_cidr = "10.1.0.0/24"
  priv_sub_cidr = "10.1.1.0/24"
  # compute instance values
  compute_display_name = "openfoam-node"
  compute_hostname = "openfoamnode"
  compute_shape = var.compute_shape
  fd_number = 1
  # block volume values
  bv_storage_gb = 51
  vpus_per_gb = 10 # 0: lower cost, 10: balanced, 20: higher performance
  bv_device_path_prefix = "/dev/oracleoci/oraclevd"
  bv_device_path_suffix = ["b"] # number of block volumes to attach
  # common
  ad_number = var.ad_number
  ad = lookup(data.oci_identity_availability_domains.ads.availability_domains[local.ad_number - 1],"name")
}
locals {
  # shorthand values
  region = lower(data.oci_identity_regions.available_regions.regions.0.key)
  private = "priv"
  public = "pub"
  subnet = "sub"
  route_table = "rt"
  security_list = "sl"
  virtual_cloud_network = "vcn"
  internet_gateway = "igw"
  block_volume = "bv"
}
variable "image" {
  type = map(string)
  default = {
    "ap-melbourne-1"  = "ocid1.image.oc1.ap-melbourne-1.aaaaaaaavpiybmiqoxcohpiih2gasjgqpsiyz4ggylyhhitmrmf3j2ycucrq"
    "ap-mumbai-1"     = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaarrsp6bazleeeghz6jcifatswozlqkoffzwxzbt2ilj2f65ngqi6a"
    "ap-osaka-1"      = "ocid1.image.oc1.ap-osaka-1.aaaaaaaafa5rhs2n3dyuncddh5oynk6gisvotvcvch3e6xwplji7phwtbqqa"
    "ap-seoul-1"      = "ocid1.image.oc1.ap-seoul-1.aaaaaaaadrnhec6655uedkshgcklewzikoqcwr65sevbu27z7vzagniihfha"
    "ap-sydney-1"     = "ocid1.image.oc1.ap-sydney-1.aaaaaaaaplq4fjdnoooudaqwgzaidh6r3lp3xdhqulx454jivy33t53hokga"
    "ap-tokyo-1"      = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaa5mpgmnwqwacey5gvczawugmo3ldgrjqnleckmnsokrqytcfkzspa"
    "ca-toronto-1"    = "ocid1.image.oc1.ca-toronto-1.aaaaaaaai25l5mqlzvhjzxvb5n4ullqu333bmalyyg3ki53vt24yn6ld7pra"
    "eu-amsterdam-1"  = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaayd4knq4bdh23zqgatgjhoajiz3mx4fy3oy62e5f45ll7trwak5ga"
    "eu-frankfurt-1"  = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa4cmgko5la45jui5cuju7byv6dgnfnjbxhwqxaei3q4zjwlliptuq"
    "eu-zurich-1"     = "ocid1.image.oc1.eu-zurich-1.aaaaaaaa4nwf5h6nl3u5cdauemg352itja6izecs7ol73z6jftsg4agpdsma"
    "me-jeddah-1"     = "ocid1.image.oc1.me-jeddah-1.aaaaaaaazrvioeng7va7w4qsuqny4jtxbvnxlf5hu7g2twn6rcwdu35u4riq"
    "sa-saopaulo-1"   = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaalfracz4kuew4yxvgydpnbitip6qsreaz7kpxlkr4p67ravvi4jnq"
    "uk-gov-london-1" = "ocid1.image.oc4.uk-gov-london-1.aaaaaaaaslh4pip7u6iopbpxujy2twi7diqrs6kfvqfhkl27esdadkqa76mq"
    "uk-london-1"     = "ocid1.image.oc1.uk-london-1.aaaaaaaa2uwbd457cd2gtviihmxw7cqfmqcug4ahdg7ivgyzla25pgrn6soa"
    "us-ashburn-1"    = "ocid1.image.oc1.iad.aaaaaaaavzjw65d6pngbghgrujb76r7zgh2s64bdl4afombrdocn4wdfrwdq"
    "us-langley-1"    = "ocid1.image.oc2.us-langley-1.aaaaaaaauckkms7acrl6to3cuhmv6hfjqwlnoxzuzophaose7pi2sfk4dzna"
    "us-luke-1"       = "ocid1.image.oc2.us-luke-1.aaaaaaaadxeycutztmvaeefvilc57lfqool2rlgl2r34juyu4jkbodx2xspq"
    "us-phoenix-1"    = "ocid1.image.oc1.phx.aaaaaaaacy7j7ce45uckgt7nbahtsatih4brlsa2epp5nzgheccamdsea2yq"
    "ap-osaka-1"      = "ocid1.image.oc1.ap-osaka-1.aaaaaaaa23apvyouh3fuiw7aqjo574zsmgdwtetato6uxgu7tct7y4uaqila"
  }
}

# ssh private key
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}
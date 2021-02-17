# vcn
resource "oci_core_vcn" "vcn" {
  cidr_block = local.vcn_cidr
  dns_label      = "${local.region}${local.virtual_cloud_network}"
  compartment_id = var.compartment_ocid
  display_name   = "${local.region}-${local.virtual_cloud_network}"
}
# rt for pub sub
resource "oci_core_route_table" "pub_rt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${local.region}-${local.public}-${local.route_table}"
  # igw
  route_rules {
    network_entity_id = oci_core_internet_gateway.igw.id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
}
# rt for priv sub
resource "oci_core_route_table" "priv_rt" {
  compartment_id  = var.compartment_ocid
  vcn_id          = oci_core_vcn.vcn.id
  display_name    = "${local.region}-${local.private}-${local.route_table}"
}
# pub sub
resource "oci_core_subnet" "pub_sub" {
  prohibit_public_ip_on_vnic = false
  cidr_block        = local.pub_sub_cidr
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_vcn.vcn.id
  display_name      = "${local.region}-${local.public}-${local.subnet}"
  dns_label         = "${local.public}${local.subnet}"
  security_list_ids = [oci_core_security_list.pub_sl.id]
  route_table_id    = oci_core_route_table.pub_rt.id
}
# priv sub
resource "oci_core_subnet" "priv_sub" {
  prohibit_public_ip_on_vnic = true
  cidr_block        = local.priv_sub_cidr
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_vcn.vcn.id
  display_name      = "${local.region}-${local.private}-${local.subnet}"
  dns_label         = "${local.private}${local.subnet}"
  security_list_ids = [oci_core_security_list.priv_sl.id]
  route_table_id    = oci_core_route_table.priv_rt.id
}
#igw
resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id
  enabled        = true
  display_name   = "${local.region}-${local.internet_gateway}"
}

# pub sl
resource "oci_core_security_list" "pub_sl" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${local.region}-${local.public}-${local.security_list}"

  # outbound traffic
  egress_security_rules {
    destination      = "0.0.0.0/0"
    protocol         = "all"
  }
  # inbound traffic
  ingress_security_rules {
    protocol = 6
    source   = "0.0.0.0/0"

    tcp_options {
      max = 22
      min = 22
    }
  }
  ingress_security_rules {
    protocol = 1
    source   = "0.0.0.0/0"
    icmp_options {
      type = 8
    }
  }
}
# priv sl
resource "oci_core_security_list" "priv_sl" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${local.region}-${local.private}-${local.security_list}"

  # outbound traffic
  egress_security_rules {
    destination      = local.pub_sub_cidr
    protocol         = "all"
  }
  # outbound traffic
  egress_security_rules {
    destination      = local.priv_sub_cidr
    protocol         = "all"
  }
  # inbound traffic
  ingress_security_rules {
    protocol = "all"
    source   = local.pub_sub_cidr
  }
  # inbound traffic
  ingress_security_rules {
    protocol = "all"
    source   = local.priv_sub_cidr
  }
}
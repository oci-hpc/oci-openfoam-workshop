# compute instance
resource "oci_core_instance" "compute" {
    availability_domain = local.ad
    compartment_id = var.compartment_ocid
    shape = local.compute_shape
    display_name = local.compute_display_name
    create_vnic_details {
        assign_public_ip = true
        display_name = local.compute_display_name
        hostname_label = local.compute_hostname
        subnet_id = oci_core_subnet.pub_sub.id
    }
    fault_domain = "FAULT-DOMAIN-${local.fd_number}"
    freeform_tags = {"Department"= "Finance"}
    metadata = {
        ssh_authorized_keys = "${var.ssh_public_key}\n${tls_private_key.ssh.public_key_openssh}"
    }
    source_details {
        source_id = var.image[var.region]
        source_type = "image"
    }
    preserve_boot_volume = false
}
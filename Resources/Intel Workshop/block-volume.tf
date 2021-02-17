# block volume
resource "oci_core_volume" "bv" {
  count = length(local.bv_device_path_suffix)
  availability_domain = local.ad
  compartment_id = var.compartment_ocid
  display_name = "${local.block_volume}-${count.index+1}"
  size_in_gbs = local.bv_storage_gb
  vpus_per_gb = local.vpus_per_gb
}
# block volume attachment
resource "oci_core_volume_attachment" "bv_attachment" {
  count = length(local.bv_device_path_suffix)
  attachment_type = "iscsi"
  instance_id = oci_core_instance.compute.id
  volume_id = oci_core_volume.bv[count.index].id
  display_name = "${local.block_volume}-attachment-${count.index+1}"
  is_read_only = false
  is_shareable = false
  device = "${local.bv_device_path_prefix}${local.bv_device_path_suffix[count.index]}"
}
# iscsi commands file
resource "null_resource" "make_iscsi_file" {
  depends_on = [oci_core_volume_attachment.bv_attachment]
  count = length(local.bv_device_path_suffix) 
  provisioner "remote-exec" {
    inline = [
      "touch /home/opc/iscsi-commands.sh",
      "chmod 755 /home/opc/iscsi-commands.sh",
      "iscsi_command_str=$(cat <<- EOF",
      "# iscsi commands for block volume attachment ${oci_core_volume_attachment.bv_attachment[count.index].display_name}, block volume ${oci_core_volume.bv[count.index].display_name}, device ${oci_core_volume_attachment.bv_attachment[count.index].device}",
      "sudo iscsiadm -m node -o new -T ${oci_core_volume_attachment.bv_attachment[count.index].iqn} -p ${oci_core_volume_attachment.bv_attachment[count.index].ipv4}:${oci_core_volume_attachment.bv_attachment[count.index].port}",
      "sudo iscsiadm -m node -o update -T ${oci_core_volume_attachment.bv_attachment[count.index].iqn} -n node.startup -v automatic",
      "sudo iscsiadm -m node -T ${oci_core_volume_attachment.bv_attachment[count.index].iqn} -p ${oci_core_volume_attachment.bv_attachment[count.index].ipv4}:${oci_core_volume_attachment.bv_attachment[count.index].port} -l",
      "EOF",
      ")",
      "echo \"$${iscsi_command_str}\" >> /home/opc/iscsi-commands.sh",
    ]
    connection {
      host        = oci_core_instance.compute.public_ip
      type        = "ssh"
      user        = "opc"
      private_key = tls_private_key.ssh.private_key_pem
    }
  }
}
# mount commands file
resource "null_resource" "make_mount_file" {
  provisioner "file" {
    content = templatefile("./mount-commands.tpl", {
      list_suffix = local.bv_device_path_suffix,
      list_devicepath = formatlist("${local.bv_device_path_prefix}%s", local.bv_device_path_suffix),
      map_devicepath_suffix = zipmap(formatlist("${local.bv_device_path_prefix}%s", local.bv_device_path_suffix), local.bv_device_path_suffix)
      })
    destination = "/home/opc/mount-commands.sh"
    connection {
      host        = oci_core_instance.compute.public_ip
      type        = "ssh"
      user        = "opc"
      private_key = tls_private_key.ssh.private_key_pem
    }
  }
}

# openfoam setup file
resource "null_resource" "make_openfoam_file" {
  provisioner "file" {
    content = templatefile("./setup-openfoam.tpl", {
      list_suffix = local.bv_device_path_suffix,
      num_cores = element(regex("[.]([0-9]+)$", var.compute_shape), 0)
      })
    destination = "/home/opc/setup-openfoam.sh"
    connection {
      host        = oci_core_instance.compute.public_ip
      type        = "ssh"
      user        = "opc"
      private_key = tls_private_key.ssh.private_key_pem
    }
  }
}

# paraview setup file
resource "null_resource" "make_paraview_file" {
  depends_on = [oci_core_volume_attachment.bv_attachment]
  provisioner "file" {
    content = templatefile("./setup-paraview.tpl", {
      map_suffix_emptyorsuffix = zipmap(local.bv_device_path_suffix, length(local.bv_device_path_suffix) > 1 ? local.bv_device_path_suffix : [""])
      })
    destination = "/home/opc/setup-paraview.sh"
    connection {
      host        = oci_core_instance.compute.public_ip
      type        = "ssh"
      user        = "opc"
      private_key = tls_private_key.ssh.private_key_pem
    }
  }
}

# motorbike setup file
resource "null_resource" "make_motorbike_file" {
  provisioner "file" {
    content = templatefile("./setup-motorbike.tpl", {
      list_suffix = local.bv_device_path_suffix,
      num_cores = element(regex("[.]([0-9]+)$", var.compute_shape), 0)
      })
    destination = "/home/opc/setup-motorbike.sh"
    connection {
      host        = oci_core_instance.compute.public_ip
      type        = "ssh"
      user        = "opc"
      private_key = tls_private_key.ssh.private_key_pem
    }
  }
}

# vncserver setup file
resource "null_resource" "send_vncserver_file" {
  provisioner "file" {
    source     = "./setup-vncserver.sh"
    destination = "/home/opc/setup-vncserver.sh"
    connection {
      host        = oci_core_instance.compute.public_ip
      type        = "ssh"
      user        = "opc"
      private_key = tls_private_key.ssh.private_key_pem
    }
  }
}


# execute commands
resource "null_resource" "execute_commands" {
  depends_on = [null_resource.make_iscsi_file, null_resource.make_mount_file, null_resource.make_openfoam_file, null_resource.make_paraview_file, null_resource.make_motorbike_file, null_resource.send_vncserver_file]
  provisioner "remote-exec" {
    inline = [
      "chmod a+x /home/opc/iscsi-commands.sh",
      "chmod a+x /home/opc/mount-commands.sh",
      "chmod a+x /home/opc/setup-openfoam.sh",
      "chmod a+x /home/opc/setup-paraview.sh",
      "chmod a+x /home/opc/setup-motorbike.sh",
      "chmod a+x /home/opc/setup-vncserver.sh",
      "/home/opc/iscsi-commands.sh",
      "/home/opc/mount-commands.sh",
      # change ownership of new directory
      "sudo chown -R opc:opc /mnt/vol${element(local.bv_device_path_suffix, 0)}",
      "/home/opc/setup-openfoam.sh",
      "/home/opc/setup-paraview.sh",
      "/home/opc/setup-motorbike.sh",
      "/home/opc/setup-vncserver.sh",
    ]
    connection {
      host        = oci_core_instance.compute.public_ip
      type        = "ssh"
      user        = "opc"
      private_key = tls_private_key.ssh.private_key_pem
    }
  }
}
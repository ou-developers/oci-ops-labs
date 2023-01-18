# Database (MySQL) compute instance
resource "oci_core_instance" "instance_db" {
  compartment_id      = var.compartment_id
  availability_domain = var.ads[0]
  display_name        = var.instance_db_name
  shape               = var.instance_shape.name
  shape_config {
    ocpus         = var.instance_shape.ocpus
    memory_in_gbs = var.instance_shape.memory_in_gbs
  }
  source_details {
    source_type = "image"
    source_id   = var.instance_db_image_id
  }
  create_vnic_details {
    subnet_id        = oci_core_subnet.ror_snt_db.id
    assign_public_ip = false
  }
  metadata = {
    ssh_authorized_keys = file("~/.ssh/id_rsa.pub")
    user_data           = data.cloudinit_config.mysql_config.rendered
  }
}

data "cloudinit_config" "mysql_config" {
  gzip          = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content = templatefile("configure_mysql.tftpl", {
      root_pass  = var.mysql_root_pass,
      rails_user = var.mysql_rails_user,
      rails_pass = var.mysql_rails_pass
    })
    filename = "configure_mysql.yaml"
  }
}
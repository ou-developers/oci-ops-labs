# App (Ruby on Rails) compute instance
resource "oci_core_instance" "instance_app" {
  compartment_id      = var.compartment_id
  availability_domain = var.ads[0]
  display_name        = var.instance_app_name
  shape               = var.instance_shape.name
  shape_config {
    ocpus         = var.instance_shape.ocpus
    memory_in_gbs = var.instance_shape.memory_in_gbs
  }
  source_details {
    source_type = "image"
    source_id   = var.instance_app_image_id
  }
  create_vnic_details {
    subnet_id        = oci_core_subnet.ror_snt_app.id
    assign_public_ip = false
    nsg_ids = [
      oci_core_network_security_group.ror_nsg_app.id
    ]
  }
  metadata = {
    ssh_authorized_keys = file("~/.ssh/id_rsa.pub")
    user_data           = data.cloudinit_config.ror_config.rendered
  }
}

data "cloudinit_config" "ror_config" {
  gzip          = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content = templatefile("configure_rails.tftpl", {
      rails_user = var.mysql_rails_user,
      rails_pass = var.mysql_rails_pass,
      db_ip_addr = oci_core_instance.instance_db.private_ip
    })
    filename = "configure_rails.yaml"
  }
}
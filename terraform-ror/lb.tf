# Front-end load balancer
resource "oci_load_balancer_load_balancer" "ror_lb" {
  compartment_id = var.compartment_id
  display_name   = var.lb_config.display_name
  subnet_ids = [
    oci_core_subnet.ror_snt_lb.id
  ]

  shape = var.lb_config.shape
  shape_details {
    maximum_bandwidth_in_mbps = var.lb_config.maximum_bandwidth_in_mbps
    minimum_bandwidth_in_mbps = var.lb_config.minimum_bandwidth_in_mbps
  }

  network_security_group_ids = [
    oci_core_network_security_group.ror_nsg_lb.id
  ]
}

# Front-end load balancer backend set
resource "oci_load_balancer_backend_set" "ror_lb_backend_set" {
  load_balancer_id = oci_load_balancer_load_balancer.ror_lb.id
  name             = var.lb_backend_config.display_name
  policy           = var.lb_backend_config.policy
  health_checker {
    protocol = var.lb_backend_config.protocol
    port     = var.lb_backend_config.port
    url_path = var.lb_backend_config.path
  }

}

# Front-end load balancer listener
resource "oci_load_balancer_listener" "ror_lb_listener" {
  load_balancer_id         = oci_load_balancer_load_balancer.ror_lb.id
  default_backend_set_name = oci_load_balancer_backend_set.ror_lb_backend_set.name

  name     = var.lb_listener_config.display_name
  port     = var.lb_listener_config.port
  protocol = var.lb_listener_config.protocol
}

resource "oci_load_balancer_backend" "ror_lb_backend" {
  load_balancer_id = oci_load_balancer_load_balancer.ror_lb.id
  backendset_name  = oci_load_balancer_backend_set.ror_lb_backend_set.name
  port             = var.lb_backend_config.port

  ip_address = oci_core_instance.instance_app.private_ip
}
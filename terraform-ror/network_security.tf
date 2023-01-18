# NSG for the load balancer
resource "oci_core_network_security_group" "ror_nsg_lb" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.ror_vcn.id
  display_name   = var.nsg_lb_display_name
}
# Allow HTTP (TCP port 80)
resource "oci_core_network_security_group_security_rule" "ror_nsg_lb_http" {
  network_security_group_id = oci_core_network_security_group.ror_nsg_lb.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 80
      min = 80
    }
  }
}
# Allow HTTPS (TCP port 443)
resource "oci_core_network_security_group_security_rule" "ror_nsg_lb_https" {
  network_security_group_id = oci_core_network_security_group.ror_nsg_lb.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 443
      min = 443
    }
  }
}

# NSG for the app servers
resource "oci_core_network_security_group" "ror_nsg_app" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.ror_vcn.id
  display_name   = var.nsg_app_display_name
}
# Allow Rails (TCP port 8080)
resource "oci_core_network_security_group_security_rule" "ror_nsg_app_rails" {
  network_security_group_id = oci_core_network_security_group.ror_nsg_app.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 8080
      min = 8080
    }
  }
}

# Security list for the database servers
resource "oci_core_security_list" "ror_sl_db" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.ror_vcn.id
  display_name   = var.sl_db_display_name

  # Allow TCP port 3306 for MySQL
  ingress_security_rules {
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    tcp_options {
      max = 3306
      min = 3306
    }
  }

  # Allow TCP port 33060 for MySQL
  ingress_security_rules {
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    tcp_options {
      max = 33060
      min = 33060
    }
  }
}
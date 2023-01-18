# Virtual Cloud Network resource block
resource "oci_core_vcn" "ror_vcn" {
  compartment_id = var.compartment_id

  display_name = var.vcn_config.display_name
  cidr_blocks  = var.vcn_config.cidr_blocks
  dns_label    = var.vcn_config.dns_label
}

# Internet gateway resource block
resource "oci_core_internet_gateway" "ror_ig" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.ror_vcn.id

  display_name = var.ig_config.display_name
  enabled      = var.ig_config.enabled
}

# NAT gateway resource block
resource "oci_core_nat_gateway" "ror_ng" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.ror_vcn.id

  display_name = var.ng_display_name
}

# Public route table resource block
resource "oci_core_route_table" "ror_rt_public" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.ror_vcn.id

  display_name = var.rt_public_display_name
  route_rules {
    network_entity_id = oci_core_internet_gateway.ror_ig.id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
}

# Private route table resource block
resource "oci_core_route_table" "ror_rt_private" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.ror_vcn.id

  display_name = var.rt_private_display_name
  route_rules {
    network_entity_id = oci_core_nat_gateway.ror_ng.id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
}

# Load balancer subnet
resource "oci_core_subnet" "ror_snt_lb" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.ror_vcn.id
  cidr_block     = var.snt_lb_config.cidr_block

  display_name               = var.snt_lb_config.display_name
  dns_label                  = var.snt_lb_config.dns_label
  prohibit_public_ip_on_vnic = false

  route_table_id = oci_core_route_table.ror_rt_public.id
}

# App subnet
resource "oci_core_subnet" "ror_snt_app" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.ror_vcn.id
  cidr_block     = var.snt_app_config.cidr_block

  display_name               = var.snt_app_config.display_name
  dns_label                  = var.snt_app_config.dns_label
  prohibit_public_ip_on_vnic = true

  route_table_id = oci_core_route_table.ror_rt_private.id
}

# Database subnet
resource "oci_core_subnet" "ror_snt_db" {
  compartment_id = var.compartment_id
  cidr_block     = var.snt_db_config.cidr_block
  vcn_id         = oci_core_vcn.ror_vcn.id

  display_name               = var.snt_db_config.display_name
  dns_label                  = var.snt_db_config.dns_label
  prohibit_public_ip_on_vnic = true

  route_table_id = oci_core_route_table.ror_rt_private.id
  security_list_ids = [
    oci_core_vcn.ror_vcn.default_security_list_id,
    oci_core_security_list.ror_sl_db.id
  ]
}
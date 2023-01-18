# Common variables
variable "compartment_id" {
  type      = string
  sensitive = true
}
variable "region" {
  type = string
}
variable "ads" {
  type = list(string)
}

# VCN variables
variable "vcn_config" {
  type = object({
    cidr_blocks  = list(string)
    display_name = string
    dns_label    = string
  })
}

# Internet gateway variables
variable "ig_config" {
  type = object({
    display_name = string
    enabled      = bool
  })
}

# NAT gateway variables
variable "ng_display_name" {
  type = string
}

# Route table variables
variable "rt_public_display_name" {
  type = string
}
variable "rt_private_display_name" {
  type = string
}

# Load balancer subnet config
variable "snt_lb_config" {
  type = object({
    display_name = string
    dns_label    = string
    cidr_block   = string
  })
}

# App server subnet config
variable "snt_app_config" {
  type = object({
    display_name = string
    dns_label    = string
    cidr_block   = string
  })
}

# Database subnet config
variable "snt_db_config" {
  type = object({
    display_name = string
    dns_label    = string
    cidr_block   = string
  })
}

# Network security variables
variable "nsg_lb_display_name" {
  type = string
}
variable "nsg_app_display_name" {
  type = string
}
variable "sl_db_display_name" {
  type = string
}

# Compute instance shape configuration
variable "instance_shape" {
  type = object({
    name          = string
    ocpus         = string
    memory_in_gbs = string
  })
}

# Compute instance image OCID for Ubuntu
variable "instance_app_image_id" {
  type = string
}

# Compute instance image OCID for Oracle Linux
variable "instance_db_image_id" {
  type = string
}

# Display name for the app server
variable "instance_app_name" {
  type = string
}

# Display name for the database server
variable "instance_db_name" {
  type = string
}

# MySQL configuration
variable "mysql_root_pass" {
  type      = string
  sensitive = true
}
variable "mysql_rails_user" {
  type      = string
  sensitive = true
}
variable "mysql_rails_pass" {
  type      = string
  sensitive = true
}

# Load Balancer configuration
variable "lb_config" {
  type = object({
    display_name              = string
    shape                     = string
    maximum_bandwidth_in_mbps = number
    minimum_bandwidth_in_mbps = number
  })
}

# Load balancer backend
variable "lb_backend_config" {
  type = object({
    display_name = string
    protocol     = string
    port         = number
    policy       = string
    path         = string
  })
}

# Load balancer listener
variable "lb_listener_config" {
  type = object({
    display_name = string
    port         = number
    protocol     = string
  })
}
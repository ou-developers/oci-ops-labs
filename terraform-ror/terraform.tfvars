# Common variables
compartment_id = "<compartment-id>"
region         = "us-phoenix-1"
ads            = ["dKYS:PHX-AD-1", "dKYS:PHX-AD-2", "dKYS:PHX-AD-3"]

# VCN variables
vcn_config = {
  cidr_blocks  = ["10.0.0.0/16"]
  display_name = "PHX-OP-LAB15-1-VCN-ROR"
  dns_label    = "vcnror"
}

# Internet gateway variables
ig_config = {
  display_name = "PHX-OP-LAB15-1-IG"
  enabled      = true
}

# NAT gateway variables
ng_display_name = "PHX-OP-LAB15-1-NG"

# Route table variables
rt_public_display_name  = "PHX-OP-LAB15-1-RT-PUBLIC"
rt_private_display_name = "PHX-OP-LAB15-1-RT-PRIVATE"

# Load balancer subnet config
snt_lb_config = {
  display_name = "PHX-OP-LAB15-1-SNT-LB"
  dns_label    = "sntlb"
  cidr_block   = "10.0.1.0/24"
}

# App server subnet config
snt_app_config = {
  display_name = "PHX-OP-LAB15-1-SNT-APP"
  dns_label    = "sntapp"
  cidr_block   = "10.0.2.0/24"
}

# Database subnet config
snt_db_config = {
  display_name = "PHX-OP-LAB15-1-SNT-DB"
  dns_label    = "sntdb"
  cidr_block   = "10.0.3.0/24"
}

# Network security variables
nsg_lb_display_name  = "PHX-OP-LAB15-1-NSG-LB"
nsg_app_display_name = "PHX-OP-LAB15-1-NSG-APP"
sl_db_display_name   = "PHX-OP-LAB15-1-SL-DB"

# Compute shape configuration
instance_shape = {
  name          = "VM.Standard.A1.Flex"
  ocpus         = "1"
  memory_in_gbs = "6"
}

# Compute image OCID
instance_app_image_id = "<ubuntu-image-id>"
instance_db_image_id  = "<oracle-linux-image-id>"

instance_app_name = "PHX-OP-LAB15-1-VM-APP"
instance_db_name  = "PHX-OP-LAB15-1-VM-DB"

# MySQL configuration
mysql_root_pass  = "RootPassword123%"
mysql_rails_user = "rubyonrails"
mysql_rails_pass = "RailsPassword123%"

# Load balancer configuration
lb_config = {
  display_name              = "PHX-OP-LAB15-1-LB"
  shape                     = "flexible"
  minimum_bandwidth_in_mbps = 10
  maximum_bandwidth_in_mbps = 10
}

# Load balancer backend
lb_backend_config = {
  display_name = "PHX-OP-LAB15-1-LBBS"
  protocol     = "HTTP"
  port         = 8080
  policy       = "LEAST_CONNECTIONS"
  path         = "/"
}

# Load balancer listener
lb_listener_config = {
  display_name = "PHX-OP-LAB15-1-LBLS"
  protocol     = "HTTP"
  port         = 80
}
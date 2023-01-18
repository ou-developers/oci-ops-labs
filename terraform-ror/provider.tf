terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">=4.100.0"
    }
  }
  required_version = ">= 1.0.0"
}

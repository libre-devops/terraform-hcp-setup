locals {
  subscription_name = "sub-${var.short}-${var.env}"
  rbac_roles        = ["User Access Administrator", "Key Vault Administrator", "Storage Blob Data Owner", "Storage File Data SMB Share Elevated Contributor"]
  write_roles       = ["Contributor", "Key Vault Administrator", "Storage Account Contributor", "Storage Blob Data Owner", "Storage File Data SMB Share Elevated Contributor"]
}


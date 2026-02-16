locals {
  subscription_name = "sub-${var.short}-${var.env}"
  roles             = ["Owner", "Key Vault Administrator", "Storage Account Contributor", "Storage Blob Data Owner"]
}


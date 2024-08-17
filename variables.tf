variable "name" {
  type        = string
  description = "The name of the Storage Account."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Storage Account."
}

variable "location" {
  type        = string
  description = "The location/region where the Storage Account is created."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the resource."
}

variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account. Valid options are `Standard` and `Premium`."

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "The account tier must be either Standard or Premium."
  }
}

variable "account_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account. Valid options are `LRS`, `GRS`, `RAGRS`, `ZRS`, `GZRS` and `RAGZRS`. Changing this forces a new resource to be created when types `LRS`, `GRS` and `RAGRS` are changed to `ZRS`, `GZRS` or `RAGZRS` and vice versa."

  validation {
    condition     = contains(["LRS", "ZRS", "GZRS", "RAGZRS", "GRS", "RAGRS"], var.account_replication_type)
    error_message = "The replication type must be one of LRS, ZRS, GZRS, RAGZRS, GRS, RAGRS."
  }
}

variable "name" {
  type        = string
  description = "The name of the Storage Account."

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.name))
    error_message = "The name must be between 3 and 24 characters long and consist only of lowercase letters and numbers."
  }
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

variable "account_kind" {
  type        = string
  description = "Defines the Kind to use for this storage account. Valid options are `Storage`, `StorageV2`, `BlobStorage`, `FileStorage`, `BlockBlobStorage`."
  default     = "StorageV2"

  validation {
    condition     = contains(["Storage", "StorageV2", "BlobStorage", "FileStorage", "BlockBlobStorage"], var.account_kind)
    error_message = "The account kind must be one of Storage, StorageV2, BlobStorage, FileStorage, BlockBlobStorage."
  }

  validation {
    condition     = contains(["FileStorage", "BlockBlobStorage"], var.account_kind) ? var.account_tier == "Premium" : true
    error_message = "FileStorage and BlockBlobStorage account kinds require Premium tier."
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

variable "https_traffic_only_enabled" {
  type        = bool
  description = "Allows https traffic only to storage service if set to true."
  default     = true
}

variable "min_tls_version" {
  type        = string
  description = "The minimum supported TLS version for the storage account. Valid values are `TLS1_0`, `TLS1_1`, `TLS1_2`."
  default     = "TLS1_2"

  validation {
    condition     = contains(["TLS1_0", "TLS1_1", "TLS1_2"], var.min_tls_version)
    error_message = "The minimum TLS version must be one of TLS1_0, TLS1_1, TLS1_2."
  }
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Controls whether data on the public internet is allowed to be read or written to the storage account."
  default     = true
}

variable "containers" {
  type = list(object({
    name                  = string
    container_access_type = optional(string, "private")
  }))
  description = "A list of containers to create within the Storage Account."

  validation {
    condition     = alltrue([for container in var.containers : contains(["private", "blob", "container"], container.container_access_type)])
    error_message = "The container access type must be one of private, blob, container."
  }
}

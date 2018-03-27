variable "region" {
  default = "europe-west1"
}

variable "region_zone" {
  default = "europe-west1-c"
}

variable "project_name" {
  description = "sebbraun-yet"
}

variable "account_file_path" {
  description = "~/.config/gcloud/terraform-admin.json"
}

variable "cluster_name" {
  default     = "bookshelf"
  description = "cluster to target"
}

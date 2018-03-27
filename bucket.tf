provider "google" {
  region      = "${var.region}"
  project     = "${var.project_name}"
  credentials = "${file(var.account_file_path)}"
}

resource "google_storage_bucket" "sebbraun_yet_bucket" {
  name          = "sebbraun-yet"
  location      = "EU"
  force_destroy = "true"
}

resource "google_storage_bucket_acl" "image-store-acl" {
  bucket = "${google_storage_bucket.sebbraun_yet_bucket.name}"

  default_acl = "publicread"
}

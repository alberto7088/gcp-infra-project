resource "google_storage_bucket" "this" {
  name          = var.bucket_name
  location      = var.region
  project       = var.gcp_project
  force_destroy = var.force_destroy
}
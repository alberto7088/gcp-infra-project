resource "google_storage_bucket" "this" {
  name          = var.bucket_name
  location      = var.region
  project       = var.gcp_project
  force_destroy = var.force_destroy
}

resource "google_storage_bucket_iam_member" "state_object_admin" {
  bucket = google_storage_bucket.this.name
  role   = "roles/storage.objectAdmin"            # allows list, get, create, update, delete
  member = "serviceAccount:${var.state_sa_email}" # set via a variable
}

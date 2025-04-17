data "archive_file" "function_zip" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = "${path.module}/function.zip"
}

locals {
  function_zip_hash = data.archive_file.function_zip.output_base64sha256
}

resource "google_storage_bucket_object" "function_archive" {
  name   = "${var.function_name}/function.zip"
  bucket = var.bucket_name
  source = data.archive_file.function_zip.output_path
}

resource "google_cloudfunctions_function" "this" {
  name                = var.function_name
  project             = var.gcp_project
  region              = var.region
  runtime             = var.runtime
  entry_point         = var.entry_point
  trigger_http        = var.trigger_http
  available_memory_mb = var.available_memory_mb
  timeout             = var.timeout

  source_archive_bucket = var.bucket_name
  source_archive_object = google_storage_bucket_object.function_archive.name

  environment_variables = merge(
    var.environment_variables,
    {
      FUNCTION_ZIP_HASH = local.function_zip_hash
    }
  )
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = var.gcp_project
  region         = var.region
  cloud_function = google_cloudfunctions_function.this.name
  role           = "roles/cloudfunctions.invoker"
  member         = "allUsers"
}
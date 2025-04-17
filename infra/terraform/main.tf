terraform {
  required_version = ">= 1.0.0"
  backend "gcs" {
    bucket = var.tf_state_bucket
    prefix = "${var.env}/terraform/state"
  }
}

provider "google" {
  project = var.gcp_project
  region  = var.region
}

module "word_counter" {
  source              = "./modules/cloud-function"
  gcp_project         = var.gcp_project
  region              = var.region
  bucket_name         = var.tf_state_bucket
  function_name       = "word_counter"
  runtime             = "python39"
  entry_point         = "get_word_count"
  trigger_http        = true
  available_memory_mb = 1024
  timeout             = 300
  source_dir          = "${path.module}/../../services/src/function-word-counter"
  environment_variables = {
    ENVIRONMENT = var.env
  }
}

output "function_name" {
  description = "Name of the deployed Cloud Function"
  value       = google_cloudfunctions_function.this.name
}
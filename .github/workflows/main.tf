resource "google_storage_bucket" "dareit-task7" {

  name          = "dareit-task7"
  location      = "US"
  storage_class = "STANDARD"

 uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_member" "member" {
  provider = google-beta
  bucket   = google_storage_bucket.dareit-task7.name
  role     = "roles/storage.objectViewer"
  member   = "allUsers"
}

resource "google_compute_instance" "dareit-vm-ci" {
  name         = "dareit-vm-tf-ci"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["dareit"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        managed_by_terraform = "true"
      }
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}

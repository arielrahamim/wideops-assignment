terraform {
    backend "gcs" {
      bucket = "wideops-assignment-bucket"
      prefix = "wideops-assignment-state" 
    }
  }
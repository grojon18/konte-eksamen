terraform{
  backend "gcs"{
    prefix      = "terraformstate"
    bucket      = "konteeksamenbucket"
    credentials = "google-key.json"
  }
}
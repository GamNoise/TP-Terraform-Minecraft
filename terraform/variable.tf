variable "project_id" {
  description = "ID du projet GCP"
  type        = string
  default     = "bionic-union-451212-m1"
}

variable "zone" {
  description = "Zone GCP"
  type        = string
  default     = "europe-west9-b"
}

variable "team_id" {
  description = "Identifiant de l'équipe"
  type        = string
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
  default     = "ai-platform"
}

variable "app_domain" {
  description = "Domain for the ingress host"
  type        = string
  default     = ""
}

variable "qdrant_storage_size" {
  description = "Qdrant persistent volume size"
  type        = string
  default     = "10Gi"
}

variable "llm_api_key" {
  description = "Groq LLM API key"
  type        = string
  sensitive   = true
}

variable "llm_base_url" {
  description = "LLM API base URL"
  type        = string
}

variable "llm_model" {
  description = "LLM model name"
  type        = string
}

variable "ghcr_username" {
  description = "GitHub username for GHCR pull"
  type        = string
}

variable "ghcr_token" {
  description = "GitHub PAT for GHCR pull"
  type        = string
  sensitive   = true
}

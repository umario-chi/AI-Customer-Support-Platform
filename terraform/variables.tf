variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Prefix for all resource names"
  type        = string
  default     = "ai-platform"
}

variable "environment" {
  description = "Environment name (e.g. production, staging)"
  type        = string
  default     = "production"
}

# --- VPC ---

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

# --- EKS ---

variable "eks_cluster_version" {
  description = "Kubernetes version for EKS"
  type        = string
  default     = "1.29"
}

variable "eks_node_instance_types" {
  description = "EC2 instance types for the EKS node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "eks_node_desired_size" {
  description = "Desired number of nodes"
  type        = number
  default     = 2
}

variable "eks_node_min_size" {
  description = "Minimum number of nodes"
  type        = number
  default     = 2
}

variable "eks_node_max_size" {
  description = "Maximum number of nodes"
  type        = number
  default     = 5
}

# --- Application ---

variable "app_domain" {
  description = "Domain for the ingress host (e.g. ai.example.com)"
  type        = string
  default     = ""
}

variable "ghcr_username" {
  description = "GitHub username for GHCR image pull"
  type        = string
}

variable "ghcr_token" {
  description = "GitHub PAT for GHCR image pull"
  type        = string
  sensitive   = true
}

variable "llm_api_key" {
  description = "Groq LLM API key"
  type        = string
  sensitive   = true
}

variable "llm_base_url" {
  description = "LLM API base URL"
  type        = string
  default     = "https://api.groq.com/openai/v1"
}

variable "llm_model" {
  description = "LLM model name"
  type        = string
  default     = "llama-3.3-70b-versatile"
}

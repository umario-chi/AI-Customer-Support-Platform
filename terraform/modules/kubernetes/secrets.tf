resource "kubernetes_secret" "app" {
  metadata {
    name      = "ai-platform-secrets"
    namespace = kubernetes_namespace.app.metadata[0].name
  }

  data = {
    DATABASE_URL = "postgresql+asyncpg://aiplatform:${random_password.postgres.result}@postgres:5432/aiplatform"
    REDIS_URL    = "redis://redis:6379/0"
    QDRANT_HOST  = "qdrant"
    QDRANT_PORT  = "6333"
    LLM_API_KEY  = var.llm_api_key
  }
}

resource "kubernetes_secret" "ghcr" {
  metadata {
    name      = "ghcr-pull-secret"
    namespace = kubernetes_namespace.app.metadata[0].name
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "ghcr.io" = {
          username = var.ghcr_username
          password = var.ghcr_token
          auth     = base64encode("${var.ghcr_username}:${var.ghcr_token}")
        }
      }
    })
  }
}

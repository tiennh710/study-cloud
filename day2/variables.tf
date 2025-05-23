variable "environment" {
  description = "Môi trường triển khai (dev/staging/prod)"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Tên dự án"
  type        = string
  default     = "my-project"
}

variable "key_pair_name" {
  description = "Base name cho key pair"
  type        = string
  default     = "ec2-key"
}

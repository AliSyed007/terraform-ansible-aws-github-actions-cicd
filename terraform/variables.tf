variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "eu-central-1"
}

variable "instance_type" {
  description = "EC2 instance type for free tier"
  type        = string
  default     = "t2.micro"
}

variable "project_name" {
  description = "Project name used for tagging resources"
  type        = string
  default     = "project-3-cicd"
}

variable "my_ip_cidr" {
  description = "Your public IP in CIDR format"
  type        = string
}

variable "allow_github_actions_ssh" {
  description = "Temporarily allow SSH from anywhere so GitHub Actions can deploy"
  type        = bool
  default     = true
}

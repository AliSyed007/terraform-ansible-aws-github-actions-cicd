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
  description = "Your public IP in CIDR format for SSH access"
  type        = string
}

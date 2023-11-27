variable "user_uuid" {
  description = "The UUID of the user"
  type        = string
  validation {
    condition        = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message    = "The user_uuid value is not a valid UUID."
  }
}

#variable "bucket_name" {
#  description = "The name of the AWS S3 bucket"
#  type        = string
#
#  validation {
#    condition     = can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.bucket_name))
#    error_message = "The bucket_name does not conform to AWS S3 bucket naming standards."
#  }
#}

variable "index_html_filepath" {
  description = "Path to the index.html file"
  type        = string
  validation {
    condition     = fileexists(var.index_html_filepath)
    error_message = "The specified index.html file does not exist or is not a valid path."
  }
}

variable "error_html_filepath" {
  description = "Path to the index.html file"
  type        = string
  validation {
    condition     = fileexists(var.error_html_filepath)
    error_message = "The specified error.html file does not exist or is not a valid path."
  }
}

variable "content_version" {
  description = "Content version (positive integer)"
  type        = number
  validation {
    condition     = var.content_version > 0
    error_message = "Content version must be a positive integer."
  }
  #default     = 1 # You can change the default value to your desired initial value.
}

variable "assets_path" {
  description = "Path to the assets folder"
  type        = string
}
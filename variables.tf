###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}



### Переменные VM


variable "platform_id" {
  description = "Платформа для виртуальной машины"
  type        = string
  default     = "standard-v2"
}


variable "cores" {
  description = "Количество ядер процессора"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Объем памяти в ГБ"
  type        = number
  default     = 2
}

variable "core_fraction" {
  description = "Доля ядра в прцентах"
  type        = number
  default     = 5
}

variable "image_id" {
  description = "ID образа для инициализации диска"
  type        = string
  default     = "fd81id4ciatai2csff2u"
}




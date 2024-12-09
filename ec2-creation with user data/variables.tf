variable "ami" {
    default = "ami-087c17d1fe0178315"
}

variable "cpu" {
    description = "CPU and others"
    default = "t2.micro"
}
variable "key" {
    description = "Key information"
    default = "Key02"
}
variable "sg" {
    description = "Security group information"
    default = "sg-090fadce25b37b60d"
}

variable "region" {
    description = "region information"
    default = "us-east-1"
}
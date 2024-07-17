variable "vpc_id" {
  type = string
}

variable "route_tags" {
  type = map(any)
  default = {
    "Name" = "MyRouteTable"
  }
}
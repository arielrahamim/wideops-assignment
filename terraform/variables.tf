###################
##### GLOBAL ######
###################

variable "project" {
  type = string
}


variable "region" {
  type = string
}


###################
#### NETWORKING ###
###################

variable "egress_rules" {
  type = list(any)
}

variable "ingress_rules" {
  type = list(any)
}

variable "subnets" {
  type = list(any)
}

variable "secondary_ranges" {
  type = map(list(any))
}

###################
####### GKE #######
###################

variable "zones" {
  type = list(any)
}

variable "node_pools" {
  type = list(any)
}

variable "node_pools_oauth_scopes" {
  type = map(list(string))
}

#################
##### COMPUTE ###
#################

variable "mongo_instances" {
  type = list(string)
}

variable "machine_type" {
  type = string
}

variable "image" {
  type = string
}
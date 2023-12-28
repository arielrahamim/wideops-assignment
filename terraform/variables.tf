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

###################
####### GKE #######
###################

variable "zones" {
  type = list(any)
}

variable "node_pools" {
  type = list(any)
}

#################
##### COMPUTE ###
#################

variable "mongo_instances" {
  type = list(string)
}


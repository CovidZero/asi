variable "app_name"       { description = "application base unique name"                                      }
variable "environment"    { description = "Name of an environment (e.g. staging, qa, production)"             }
variable "region"         { description = "AWS region to build this infrastructure"                          }
variable "az_count"       { description = "Number of AZs to cover in a given AWS region"                      }
variable "vpc_cidr"       { description = "The CIDR block of the vpc"                                         }
variable "app_image"      { description = "Docker image of application"                                       }
variable "app_port"       { description = "Port exposed by the docker image to redirect traffic to"           }
variable "app_count"      { description = "Number of docker containers to run"                                }
variable "fargate_cpu"    { description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)" }
variable "fargate_memory" { description = "Fargate instance memory to provision (in MiB)"                     }
variable "scale_min"      { description = "Minimun nodes to scale down"                                       }
variable "scale_max"      { description = "Maximum nodes to scale up"                                         }
variable "base_domain"    { description = "base route53-managed top level domain"                             }
variable "use_ssl"        { description = "Use SSL: yes or no"                                                }

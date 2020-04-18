module "app_front" {
  source             = "./modules/s3/static-website"
  name               = var.hostname_app_front_default
  base_domain        = var.base_domain
  versioning_enabled = true
  sourceIps = [
    "2400:cb00::/32",
    "2405:8100::/32",
    "2405:b500::/32",
    "2606:4700::/32",
    "2803:f800::/32",
    "2c0f:f248::/32",
    "2a06:98c0::/29",
    "103.21.244.0/22",
    "103.22.200.0/22",
    "103.31.4.0/22",
    "104.16.0.0/12",
    "108.162.192.0/18",
    "131.0.72.0/22",
    "141.101.64.0/18",
    "162.158.0.0/15",
    "172.64.0.0/13",
    "173.245.48.0/20",
    "188.114.96.0/20",
    "190.93.240.0/20",
    "197.234.240.0/22",
    "198.41.128.0/17",
    "173.245.48.0/20",
    "103.21.244.0/22",
    "103.22.200.0/22",
    "103.31.4.0/22",
    "141.101.64.0/18",
    "108.162.192.0/18",
    "190.93.240.0/20",
    "188.114.96.0/20",
    "197.234.240.0/22",
    "198.41.128.0/17",
    "162.158.0.0/15",
    "104.16.0.0/12",
    "172.64.0.0/13",
    "131.0.72.0/22"
  ]
}


module "s3_buildndeploy" {
  source            = "./modules/buildndeploy/s3"
  bucket_name       = module.app_front.bucket_id
  environment       = var.environment
  repository_name   = var.static_repository_name
  repository_owner  = var.repository_owner
  repository_branch = var.repository_branch
  github_token      = var.github_token
}


module "hostname_app_front" {
  source      = "./modules/ns"
  app_name    = var.hostname_app_front_default
  alb_url     = module.app_front.bucket_website_domain
  base_domain = var.base_domain
  is_proxied  = true
}


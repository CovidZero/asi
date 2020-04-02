# S3 Terraform Module

This module was created to keep the S3 bucket creation as simples as it is.

## Providers

| Name | Version |
|------|---------|
| aws | 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| block\_public\_acls | Whether Amazon S3 should block public ACLs for this bucket | `bool` | `false` | no |
| block\_public\_policy | Whether Amazon S3 should block public bucket policies for this bucket | `bool` | `false` | no |
| ignore\_public\_acls | Whether Amazon S3 should ignore public ACLs for this bucket | `bool` | `false` | no |
| name | Name that will be used by this given bucket | `string` | n/a | yes |
| restrict\_public\_buckets | Whether Amazon S3 should restrict public bucket policies for this bucket | `bool` | `false` | no |
| versioning\_enabled | This variable when set to `true` enabled versioning feature on S3 | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket\_arn | Bucket ARN |
| bucket\_domain\_name | FQDN of bucket |
| bucket\_id | Bucket Name (aka ID) |




## Usage Example

Most single usage 
```
module "my_new_bucket"{
    source = "./module/s3"

    name = "my-bucket"
}
```

```
module "my_new_bucket"{
    source = "./module/s3"

    name               = "my-bucket"
    versioning_enabled = true

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}
```

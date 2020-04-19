/* ========================================================================= */
/* ================= STORAGE =============================================== */
/* ========================================================================= */

/* ================================================================ Artifact */

resource "aws_s3_bucket" "main" {
  bucket = "${var.bucket_name}-${var.environment}-artifacts"
  acl    = "private"
  tags = {
    Name        = "${var.bucket_name}-${var.environment}"
    Environment = var.environment
  }
}

/* ========================================================================= */
/* ================= BUILD ================================================= */
/* ========================================================================= */

/* =============================================================== CodeBuild */

resource "aws_codebuild_project" "node_build" {
  name          = "${var.repository_name}-${var.environment}-build"
  build_timeout = "10"
  service_role  = aws_iam_role.buildndeploy-role.arn
  artifacts {
    type      = "CODEPIPELINE"
    packaging = "ZIP"
  }
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:4.0"
    type         = "LINUX_CONTAINER"
  }
  source {
    type = "CODEPIPELINE"
    buildspec = templatefile("${path.module}/appspec.yml", {
      app_environment = var.environment,
    })
  }
}

/* ========================================================================= */
/* ================= DEPLOY ================================================ */
/* ========================================================================= */

/* ============================================================ CodePipeline */

resource "aws_codepipeline" "pipeline" {
  name     = "${var.repository_name}-${var.environment}-pipeline"
  role_arn = aws_iam_role.buildndeploy-role.arn
  artifact_store {
    location = aws_s3_bucket.main.bucket
    type     = "S3"
  }
  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source"]
      configuration = {
        Owner      = var.repository_owner
        Repo       = var.repository_name
        Branch     = var.repository_branch
        OAuthToken = var.github_token
      }
    }
  }

  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source"]
      output_artifacts = ["package"]
      configuration = {
        ProjectName = "${var.repository_name}-${var.environment}-build"
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "S3"
      input_artifacts = ["package"]
      version         = "1"
      configuration = {
        BucketName = var.bucket_name
        Extract    = "true"
      }
    }
  }
}

/* ========================================================================= */
/* ================= SECURITY ============================================== */
/* ========================================================================= */

/* =============================================================== IAM Roles */

resource "aws_iam_role" "buildndeploy-role" {
  name               = "${var.repository_name}-${var.environment}-buildndeploy-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "codebuild.amazonaws.com"
        ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "buildndeploy-policy" {
  name   = "${var.repository_name}-${var.environment}-buildndeploy-policy"
  role   = aws_iam_role.buildndeploy-role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "codebuild:*",
        "s3:*",
        "logs:PutLogEvents",
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "iam:GetRole",
        "iam:PassRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

}


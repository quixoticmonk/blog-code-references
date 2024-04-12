mock_provider "aws" {
  alias = "mock_aws"
  mock_resource "aws_s3_bucket" {
    defaults = {
      id  = "testbucket"
      arn = "arn:aws:s3:::test_bucket"
    }
  }
}

run "validate_mock_apply" {
  providers = {
    aws = aws.mock_aws
  }
  variables {
    bucket_name = "testbucket"
  }
  assert {
    condition     = aws_s3_bucket.this.id == "testbucket"
    error_message = "Bucket name doesn't match the expected value"
  }
}

run "variable_validations_length"{
   command = plan
  providers = {
    aws = aws.mock_aws
  }
  variables {
    bucket_name = "testbuckettestbuckettestbuckettestbuckettestbucketvtestbuckettestbuckettestbucket"
  }
  expect_failures=[var.bucket_name]
}

run "variable_validations_hyphen"{
   command = plan
  providers = {
    aws = aws.mock_aws
  }
  variables {
    bucket_name = "test_bucket"
  }
  expect_failures=[var.bucket_name]
}

run "variable_validations_startingchar"{
   command = plan
  providers = {
    aws = aws.mock_aws
  }
  variables {
    bucket_name = "_testbucket"
  }
  expect_failures=[var.bucket_name]
}

run "variable_validations_periods"{
   command = plan
  providers = {
    aws = aws.mock_aws
  }
  variables {
    bucket_name = "test..bucket"
  }
  expect_failures=[var.bucket_name]
}

run "variable_validations_ip"{
   command = plan
  providers = {
    aws = aws.mock_aws
  }
  variables {
    bucket_name = "1.2.3.4"
  }
  expect_failures=[var.bucket_name]
}

run "variable_validations_xn"{
   command = plan
  providers = {
    aws = aws.mock_aws
  }
  variables {
    bucket_name = "xn--testbucket"
  }
  expect_failures=[var.bucket_name]
}

run "variable_validations_sthree"{
   command = plan
  providers = {
    aws = aws.mock_aws
  }
  variables {
    bucket_name = "sthree-testbucket"
  }
  expect_failures=[var.bucket_name]
}

run "variable_validations_s3alias"{
   command = plan
  providers = {
    aws = aws.mock_aws
  }
  variables {
    bucket_name = "testbucket-s3alias"
  }
  expect_failures=[var.bucket_name]
}

run "variable_validations_--ol-s3"{
   command = plan
  providers = {
    aws = aws.mock_aws
  }
  variables {
    bucket_name = "testbucket--ol-s3"
  }
  expect_failures=[var.bucket_name]
}
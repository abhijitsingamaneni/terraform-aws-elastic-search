resource "aws_elasticsearch_domain" "elastic-cluster" {
  domain_name           = var.domain
  elasticsearch_version = "7.1"
  access_policies       = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "es:*",
      "Principal": {
        "AWS": "*"
      },
      "Effect": "Allow",
      "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain}/*"
    }
  ]
}
POLICY

  ebs_options {
    ebs_enabled = "true"
    volume_size = "30"

  }
  
  cluster_config {
    instance_type = "r4.large.elasticsearch"
    instance_count= "5"
    dedicated_master_enabled = "true"
    dedicated_master_count = "3"
    dedicated_master_type = "r5.large.elasticsearch"
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  tags = {
    Domain = var.domain
  }
}
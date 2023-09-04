resource "aws_finspace_kx_cluster" "rdb-cluster" {
  depends_on            = [aws_finspace_kx_cluster.discovery-cluster]
  count                 = var.rdb-count
  name                  = "rdb-cluster-${count.index+1}"
  environment_id        = var.environment-id
  type                  = "RDB"
  release_label         = "1.0"
  az_mode               = "SINGLE"
  availability_zone_id  = var.availability-zone
  initialization_script = var.init-script



  savedown_storage_configuration {
    type = "SDS01"
    size = 10
  }

  capacity_configuration {
    node_type  = "kx.s.large"
    node_count = 1
  }

  code {
    s3_bucket = var.s3-bucket
    s3_key    = var.s3-key
  }

  command_line_arguments =  {
    procname   = "rdb_trade"
    proctype   = "rdb"
    noredirect = "true"
  }

  vpc_configuration {
    vpc_id             = var.vpc
    security_group_ids = var.security-group
    subnet_ids         = var.subnet
    ip_address_type    = "IP_V4"
  }
}
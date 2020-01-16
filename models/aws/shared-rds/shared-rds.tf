module piece-rds-database {
  source = "../../../pieces/aws-rds"

  rds-config = var.shared-rds-config
}
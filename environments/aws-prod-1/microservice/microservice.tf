module microservice {
  source = "../../../models/aws/microservice"

  microservice-config = var.microservice-config
  db-config = data.terraform_remote_state.aws-prod-1-shared-rds.output.shared-rds-config
}
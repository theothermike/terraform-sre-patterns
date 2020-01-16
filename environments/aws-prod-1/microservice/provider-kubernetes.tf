provider kubernetes {
  config_context = data.terraform_remote_state.aws-prod-1-kops.output.kops-config["context"]
}
TerraformVersion = "1.1.9"

install_terraform_linux:
	wget https://releases.hashicorp.com/terraform/$(TerraformVersion)/terraform_$(TerraformVersion)_linux_amd64.zip
	unzip terraform_$(TerraformVersion)_linux_amd64.zip

install_terraform_win:
	powershell -ExecutionPolicy Bypass wget https://releases.hashicorp.com/terraform/$(TerraformVersion)/terraform_$(TerraformVersion)_windows_amd64.zip -outfile terraform_$(TerraformVersion)_windows_amd64.zip
	powershell -ExecutionPolicy Bypass expand-archive -Path terraform_$(TerraformVersion)_windows_amd64.zip -DestinationPath . -Force

terraform_rename:
	mv ./route53.$(ENVIRONMENT) ./route53.tf
	
terraform_validate:
	./terraform version\
	&& ./terraform init -backend-config='backend-configs/terraform.backend.$(ENVIRONMENT).tfvars' \
	&& ./terraform refresh -var-file=tfenvs/terraform.$(ENVIRONMENT).tfvars \
	&& ./terraform validate

terraform_plan:
	./terraform plan -var-file=tfenvs/terraform.$(ENVIRONMENT).tfvars -out="plans/terraform.$(ENVIRONMENT).tfplan"

terraform_apply:
	./terraform version\
	&& ./terraform init -backend-config='backend-configs/terraform.backend.$(ENVIRONMENT).tfvars' \
	&& ./terraform apply -var-file=tfenvs/terraform.$(ENVIRONMENT).tfvars -auto-approve

terraform_clean:
	rm -rf .terraform
	rm -rf ".git"
	rm -rf ".gitignore"
	rm -rf "terraform_$(TerraformVersion)_windows_amd64.zip"
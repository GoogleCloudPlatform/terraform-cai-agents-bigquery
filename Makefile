# Copyright 2024 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ifndef project
    override project := $(shell gcloud config get-value project 2>&1 | grep -v 'Your active configuration is: ')
endif

# Define Timestamped Files
INIT_TIMESTAMP = build/.make.init.done

# Default target
.PHONY: all
all: help


# Initialize Terraform
${INIT_TIMESTAMP}:
	mkdir -p docs
	mkdir -p build
	terraform init
	@touch ${INIT_TIMESTAMP}

.PHONY: init
init: ${INIT_TIMESTAMP}


# Check the Active GCloud Login
.PHONY: gcloud-check
gcloud-check:
	@echo -n "Active GCP Login: "
	@gcloud config list account --format "value(core.account)"
	@echo -n "Active GCP Project: "
	@gcloud config get-value project 2>&1 | grep -v 'Your active configuration is: '


# Login and Configure GCloud Project
.PHONY: login
login:
	@gcloud auth application-default login


# Configure GCloud Project
.PHONY: set-project
set-project:
	@echo -n "Using Active gcloud config project"
	gcloud config set project "${project}"
	gcloud auth application-default set-quota-project "${project}"


# Plan Terraform Deployment
.PHONY: plan
plan: init
	touch config.tfvars
	terraform plan -out .terraform.plan -var-file=config.tfvars


# Create a Graph of the Terraform Deployment
.PHONY: graph
graph: plan
	terraform graph -plan=.terraform.plan | dot -Tpng > docs/assets/terraform-graph.png


# Plan Terraform Deployment
.PHONY: happen
happen: .terraform.plan
	terraform apply .terraform.plan


# Destroy Terraform Deployment
.PHONY: disappear
disappear:
	touch config.tfvars
	terraform destroy -var-file=config.tfvars


# Clean Environment
.PHONY: clean
clean:
	rm -rf .terraform .terraform.plan .terraform.lock.hcl *.tfstate *.tfstate.* build
	find . -type d -name "build" -exec rm -r {} +


# Help
.PHONY: help
help:
	@echo "Usage:"
	@echo "  make gcloud-check      - Check the gcloud active login and project"
	@echo "  make login             - Change the gcloud login and project"
	@echo "  make set-project       - Change the gcloud project"
	@echo "  make init              - Initiatize Terraform providers and modules"
	@echo "  make plan              - Plan Terraform resource changes"
	@echo "  make happen            - Deploy Terraform resources"
	@echo "  make disappear         - Destroy Terraform resources"
	@echo "  make clean             - Clean environment"
	@echo "  make help              - Show help"

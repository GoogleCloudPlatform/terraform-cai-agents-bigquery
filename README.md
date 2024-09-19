# terraform-cai-agents-bigquery

This is not an officially supported Google product. This project is not
eligible for the [Google Open Source Software Vulnerability Rewards
Program](https://bughunters.google.com/open-source-security).

This Terraform module creates a BigQuery dataset and the necessary tables for [Dialogflow CX interaction logging](https://cloud.google.com/dialogflow/cx/docs/concept/export-bq) and [CCAI Insights V3 Exports](https://cloud.google.com/contact-center/insights/docs/bigquery-v3-schema).  It supports optional editor and viewer permissions grants that can be actioned at create time.

Here is a generated dependency graph of the resources provisioned by this module.

![Terraform Module Graph](/docs/assets/terraform-graph.png)


# Usage

Using this module is as simple as defining a **module** resource in your Terraform configuration and referencing this Git repository as the **source**.

## Inputs

| Parameter | Required | Description | Default Value |
| --------------- | --------------- | --------------- | --------------- |
| project_id | Yes | The GCP project name.  |  |
| region | Yes | The [BigQuery GCP region](https://cloud.google.com/bigquery/docs/locations). |  |
| dataset_id | Yes | The BigQuery dataset ID.  Must contain only letters (a-z, A-Z), numbers (0-9), or underscores (_). |  |
| insights_v3_table_name | No | The [BigQuery CCAI Insights v3](https://cloud.google.com/contact-center/insights/docs/bigquery-v3-schema) table name. | insights_v3 |
| interaction_logs_table_name | No | The [BigQuery CAI Agents interaction logs](https://cloud.google.com/dialogflow/cx/docs/concept/export-bq) table name. | interaction_logs |
| deletion_protection | No | The flag indicating whether the resources should be created with [deletion protection](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table#deletion_protection) enabled.  | false |
| service_accounts_editors | No | The map of service account emails to provide Editor/User permissions. |  |
| service_accounts_viewers | No | The map of service account emails to provide Viewer/User permissions. |  |

## Build as Standalone


### Configure Deployment Variables

Create a file config.tfvars in the root directory of your project (it won't be commited to the repository due to .gitignore).

```
project_id                  = "your-gcp-project-id"
region                      = "us-central1"
dataset_id                  = "your_bigquery_dataset_id"
insights_v3_table_name      = "insights_v3"
interaction_logs_table_name = "interaction_logs_v2"
deletion_protection         = true

service_accounts_editors = {
  "Agent Logging" = "service-account-1@your-project.iam.gserviceaccount.com"
  "Custom Analytics" = "another-account@your-project.iam.gserviceaccount.com"
}

service_accounts_viewers = {
  "Dashboard Viewer" = "viewer-account@your-project.iam.gserviceaccount.com"
}
```

### Configure Terraform Providers

When building as a standalone package, configure terraform provides by creating a Terraform file, for example **provider.tf**, with the following configuration.

```
provider "google" {
  project = var.project_id
  region = var.region
  user_project_override = true
  billing_project = var.project_id
}

terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}
```


### Create Terraform Plan

After creating the above config, create the Terraform plan.

```
make plan
```

### Apply the Terraform Plan

When the above completes, apply the plan to deploy the resources.

```
make happen
```

### Destroy All Created Resources

When you're ready to delete all resources deployed by this module, execute Terraform destroy.

```
make disappear
```


## Build as an imported Module


```
# Create the Agents BigQuery dataset and tables
module "cai_agents_bigquery" {
    source = "github.com/GoogleCloudPlatform/terraform-cai-agents-bigquery?ref=v0.0.1"

    project_id                  = "your-gcp-project-id"
    region                      = "us"
    dataset_id                  = "your_bigquery_dataset_id"
    insights_v3_table_name      = "insights_v3"
    interaction_logs_table_name = "interaction_logs"
    deletion_protection         = false

    service_accounts_editors = {
        "Agent Logging" = "service-account-1@your-project.iam.gserviceaccount.com"
        "Custom Analytics" = "another-account@your-project.iam.gserviceaccount.com"
    }

    service_accounts_viewers = {
        "Dashboard Viewer" = "viewer-account@your-project.iam.gserviceaccount.com"
    }
}
```

## Outputs


The following outputs are available for this module.

| Parameter | Required | Description | 
| --------------- | --------------- | --------------- | 
| project_id | Yes | The GCP project name.  |
| region | Yes | The [BigQuery GCP region](https://cloud.google.com/bigquery/docs/locations). | 
| dataset_id | Yes | The BigQuery dataset ID.  Must contain only letters (a-z, A-Z), numbers (0-9), or underscores (_). |
| insights_v3_table_name | No | The [BigQuery CCAI Insights v3](https://cloud.google.com/contact-center/insights/docs/bigquery-v3-schema) table name. | 
| interaction_logs_table_name | No | The [BigQuery CAI Agents interaction logs](https://cloud.google.com/dialogflow/cx/docs/concept/export-bq) table name. | 

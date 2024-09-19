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

variable "project_id" {
  description = "The GCP project name."
  type        = string
}

variable "region" {
  description = "The BigQuery GCP region.  See: https://cloud.google.com/bigquery/docs/locations."
  type        = string
}

variable "dataset_id" {
  description = "The BigQuery dataset ID.  Must contain only letters (a-z, A-Z), numbers (0-9), or underscores (_)."
  type        = string
}

variable "insights_v3_table_name" {
  description = "The BigQuery CCAI Insights v3 table name.  See: https://cloud.google.com/contact-center/insights/docs/bigquery-v3-schema."
  type        = string
  default     = "insights_v3"
}

variable "interaction_logs_table_name" {
  description = "The BigQuery CAI Agents interaction logs table name.  See: https://cloud.google.com/dialogflow/cx/docs/concept/export-bq."
  type        = string
  default     = "interaction_logs"
}

variable "deletion_protection" {
  description = "The flag indicating whether the resources should be created with deletion protection enabled."
  type        = bool
  default     = false
}

variable "service_accounts_editors" {
  description = "The map of service account emails to provide Editor permissions."
  type        = map(string)
  default     = {}
}

variable "service_accounts_viewers" {
  description = "The map of service account emails to provide Viewer permissions."
  type        = map(string)
  default     = {}
}

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

# The GCP project name.
output "project_id" {
    value = google_bigquery_dataset.agents_dataset.project
    description = "The GCP project name."
}

# The BigQuery GCP region.
# See: https://cloud.google.com/bigquery/docs/locations.
output "region" {
    value = google_bigquery_dataset.agents_dataset.location
    description = "The BigQuery GCP region.  See: https://cloud.google.com/bigquery/docs/locations."
}

# The BigQuery dataset ID.
# Must contain only letters (a-z, A-Z), numbers (0-9), or underscores (_).
output "dataset_id" {
    value = google_bigquery_dataset.agents_dataset.dataset_id
    description = "The BigQuery dataset ID.  Must contain only letters (a-z, A-Z), numbers (0-9), or underscores (_)."
}

# The BigQuery CAI Agents interaction logs table name.
# See: https://cloud.google.com/dialogflow/cx/docs/concept/export-bq.
output "interaction_logs_table_name" {
    value = google_bigquery_table.interaction_logs.table_id
    description = "The BigQuery CAI Agents interaction logs table name.  See: https://cloud.google.com/dialogflow/cx/docs/concept/export-bq."
}

# The BigQuery CCAI Insights v3 table name.
# See: https://cloud.google.com/contact-center/insights/docs/bigquery-v3-schema.
output "insights_v3_table_name" {
    value = google_bigquery_table.insights_v3_table.table_id
    description = "The BigQuery CCAI Insights v3 table name.  See: https://cloud.google.com/contact-center/insights/docs/bigquery-v3-schema."
}

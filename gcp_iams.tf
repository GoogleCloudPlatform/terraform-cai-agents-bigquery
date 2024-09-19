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

# Grant Editor Access to dataset.
resource "google_bigquery_dataset_access" "grant_editor_access" {
    depends_on = [
        google_project_service.iam_manager_api,
        google_project_service.bigquery_api,
        google_bigquery_dataset.agents_dataset,
    ]

    for_each = var.service_accounts_editors
    dataset_id = var.dataset_id
    role = "roles/bigquery.dataEditor"
    user_by_email = each.value
}

# Grant Editors Job Create
resource "google_project_iam_member" "grant_editor_job_create" {
    depends_on = [
        google_project_service.iam_manager_api,
        google_project_service.bigquery_api,
        google_bigquery_dataset.agents_dataset,
    ]

    for_each = var.service_accounts_editors
    project = var.project_id
    role   = "roles/bigquery.jobUser"
    member = "serviceAccount:${each.value}"
}

# Grant Editor Access to dataset.
resource "google_bigquery_dataset_access" "grant_viewer_access" {
    depends_on = [
        google_project_service.iam_manager_api,
        google_project_service.bigquery_api,
        google_bigquery_dataset.agents_dataset,
    ]

    for_each = var.service_accounts_viewers
    dataset_id = var.dataset_id
    role = "roles/bigquery.dataViewer"
    user_by_email = each.value
}

# Grant Viewers Job Create
resource "google_project_iam_member" "grant_viewer_job_create" {
    depends_on = [
        google_project_service.iam_manager_api,
        google_project_service.bigquery_api,
        google_bigquery_dataset.agents_dataset,
    ]

    for_each = var.service_accounts_viewers
    project = var.project_id
    role   = "roles/bigquery.jobUser"
    member = "serviceAccount:${each.value}"
}

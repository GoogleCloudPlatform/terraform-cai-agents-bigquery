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

resource "google_bigquery_dataset" "agents_dataset" {
  depends_on = [
    google_project_service.bigquery_api,
  ]
  dataset_id                  = "${var.dataset_id}"
  location                    = var.region
  description                 = "Dataset for storing CAI agent performance and operational data."
  delete_contents_on_destroy  = true

  lifecycle {
    ignore_changes = [access]
  }
}

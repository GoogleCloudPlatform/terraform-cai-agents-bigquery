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

resource "google_bigquery_table" "interaction_logs" {
  dataset_id          = google_bigquery_dataset.agents_dataset.dataset_id
  table_id            = var.interaction_logs_table_name
  deletion_protection = var.deletion_protection

  schema = jsonencode([
    {
      name = "project_id",
      type = "STRING"
    },
    {
      name = "agent_id",
      type = "STRING"
    },
    {
      name = "conversation_name",
      type = "STRING"
    },
    {
      name = "turn_position",
      type = "INTEGER"
    },
    {
      name = "request_time",
      type = "TIMESTAMP"
    },
    {
      name = "language_code",
      type = "STRING"
    },
    {
      name = "request",
      type = "JSON"
    },
    {
      name = "response",
      type = "JSON"
    },
    {
      name = "partial_responses",
      type = "JSON"
    },
    {
      name = "derived_data",
      type = "JSON"
    },
    {
      name = "conversation_signals",
      type = "JSON"
    },
    {
      name = "bot_answer_feedback",
      type = "JSON"
    }
  ])
}

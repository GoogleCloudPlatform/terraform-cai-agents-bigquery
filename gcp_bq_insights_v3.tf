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

resource "google_bigquery_table" "insights_v3_table" {
  dataset_id          = google_bigquery_dataset.agents_dataset.dataset_id
  table_id            = var.insights_v3_table_name
  deletion_protection = var.deletion_protection

  schema = jsonencode([
    {
      name = "conversationName",
      type = "STRING",
      mode = "NULLABLE",
      description = "Name of the conversation resource."
    },
    {
      name = "audioFileUri",
      type = "STRING",
      mode = "NULLABLE",
      description = "Location of the audio file on Google Cloud Storage."
    },
    {
      name = "agentId",
      type = "STRING",
      mode = "NULLABLE",
      description = "The user-provided identifier for the agent who handled the conversation."
    },
    {
      name = "dialogflowConversationProfileId",
      type = "STRING",
      mode = "NULLABLE",
      description = "The Dialogflow conversation profile ID of this conversation."
    },
    {
      name = "startTimestampUtc",
      type = "INTEGER",
      mode = "NULLABLE",
      description = "The time in seconds at which the conversation started."
    },
    {
      name = "loadTimestampUtc",
      type = "INTEGER",
      mode = "NULLABLE",
      description = "The time in seconds at which the conversation was loaded into Insights."
    },
    {
      name = "analysisTimestampUtc",
      type = "INTEGER",
      mode = "NULLABLE",
      description = "The time in seconds at which the most recent analysis was performed."
    },
    {
      name = "year",
      type = "INTEGER",
      mode = "NULLABLE",
      description = "Year date part of `loadTimestampUtc`."
    },
    {
      name = "month",
      type = "INTEGER",
      mode = "NULLABLE",
      description = "Month date part of `loadTimestampUtc`."
    },
    {
      name = "day",
      type = "INTEGER",
      mode = "NULLABLE",
      description = "Day date part of `loadTimestampUtc`."
    },
    {
      name = "durationNanos",
      type = "INTEGER",
      mode = "NULLABLE",
      description = "Conversation duration in nanoseconds."
    },
    {
      name = "silenceNanos",
      type = "INTEGER",
      mode = "NULLABLE",
      description = "Number of nanoseconds calculated to be in silence."
    },
    {
      name = "silencePercentage",
      type = "FLOAT",
      mode = "NULLABLE",
      description = "Percentage of the total conversation spent in silence."
    },
    {
      name = "agentSpeakingPercentage",
      type = "FLOAT",
      mode = "NULLABLE",
      description = "Percentage of the conversation with the agent speaking."
    },
    {
      name = "clientSpeakingPercentage",
      type = "FLOAT",
      mode = "NULLABLE",
      description = "Percentage of the conversation with the client speaking."
    },
    {
      name = "agentSentimentScore",
      type = "FLOAT",
      mode = "NULLABLE",
      description = "Agent sentiment score between -1.0 (negative) and 1.0 (positive)."
    },
    {
      name = "agentSentimentMagnitude",
      type = "FLOAT",
      mode = "NULLABLE",
      description = "A non-negative number from zero to infinity that represents the absolute magnitude of the agent sentiment regardless of score."
    },
    {
      name = "clientSentimentScore",
      type = "FLOAT",
      mode = "NULLABLE",
      description = "Client sentiment score between -1.0 (negative) and 1.0 (positive)."
    },
    {
      name = "clientSentimentMagnitude",
      type = "FLOAT",
      mode = "NULLABLE",
      description = "A non-negative number from zero to infinity that represents the absolute magnitude of client sentiment regardless of score."
    },
    {
      name = "transcript",
      type = "STRING",
      mode = "NULLABLE",
      description = "The complete text transcript of the conversation."
    },
    {
      name = "turnCount",
      type = "INTEGER",
      mode = "NULLABLE",
      description = "The number of turns taken in the conversation."
    },
    {
      name = "languageCode",
      type = "STRING",
      mode = "NULLABLE",
      description = "Language code of the conversation."
    },
    {
      name = "medium",
      type = "STRING",
      mode = "NULLABLE",
      description = "Medium of the conversation."
    },
    {
      name = "issues",
      type = "RECORD",
      mode = "REPEATED",
      description = "The list of all issues of the conversation.",
      fields = [
        {
          name = "name",
          type = "STRING",
          mode = "NULLABLE",
          description = "The name of the issue."
        },
        {
          name = "score",
          type = "FLOAT",
          mode = "NULLABLE",
          description = "Score indicating the likelihood of the issue assignment, between 0 and 1.0."
        },
        {
          name = "issueModelId",
          type = "STRING",
          mode = "NULLABLE",
          description = "ID of the issue model that generated the issue assignment."
        },
        {
          name = "issueId",
          type = "STRING",
          mode = "NULLABLE",
          description = "ID of the assigned issue."
        }
      ]
    },
    {
      name = "entities",
      type = "RECORD",
      mode = "REPEATED",
      description = "The list of all spoken entities.",
      fields = [
        {
          name = "name",
          type = "STRING",
          mode = "NULLABLE",
          description = "Name of the entity."
        },
        {
          name = "type",
          type = "STRING",
          mode = "NULLABLE",
          description = "Type of the entity."
        },
        {
          name = "sentimentScore",
          type = "FLOAT",
          mode = "NULLABLE",
          description = "The entity sentiment score between -1.0 (negative) and 1.0 (positive)."
        },
        {
          name = "sentimentMagnitude",
          type = "FLOAT",
          mode = "NULLABLE",
          description = "A non-negative number from zero to infinity that represents the absolute magnitude of the entity sentiment regardless of score."
        },
        {
          name = "salience",
          type = "FLOAT",
          mode = "NULLABLE",
          description = "Salience score of the entity."
        },
        {
          name = "speakerTag",
          type = "INTEGER",
          mode = "NULLABLE",
          description = "The speaker that the entity mention originated from."
        }
      ]
    },
    {
      name = "labels",
      type = "RECORD",
      mode = "REPEATED",
      description = "The list of all user-provided labels.",
      fields = [
        {
          name = "key",
          type = "STRING",
          mode = "NULLABLE",
          description = "User-provided label key."
        },
        {
          name = "value",
          type = "STRING",
          mode = "NULLABLE",
          description = "User-provided label value."
        }
      ]
    },
    {
      name = "words",
      type = "RECORD",
      mode = "REPEATED",
      description = "The list of all spoken words.",
      fields = [
        {
          name = "word",
          type = "STRING",
          mode = "NULLABLE",
          description = "The transcribed word."
        },
        {
          name = "startOffsetNanos",
          type = "INTEGER",
          mode = "NULLABLE",
          description = "Time offset in nanoseconds of the start of this word relative to the beginning of the conversation."
        },
        {
          name = "endOffsetNanos",
          type = "INTEGER",
          mode = "NULLABLE",
          description = "Time offset in nanoseconds of the end of this word relative to the beginning of the conversation."
        },
        {
          name = "speakerTag",
          type = "INTEGER",
          mode = "NULLABLE",
          description = "The speaker that the word originated from."
        },
        {
          name = "languageCode",
          type = "STRING",
          mode = "NULLABLE",
          description = "Language code."
        }
      ]
    },
    {
      name = "sentences",
      type = "RECORD",
      mode = "REPEATED",
      description = "The list of conversation sentences.",
      fields = [
        {
          name = "sentence",
          type = "STRING",
          mode = "NULLABLE",
          description = "The transcribed sentence."
        },
        {
          name = "sentimentScore",
          type = "FLOAT",
          mode = "NULLABLE",
          description = "The sentence sentiment score between -1.0 (negative) and 1.0 (positive)."
        },
        {
          name = "sentimentMagnitude",
          type = "FLOAT",
          mode = "NULLABLE",
          description = "A non-negative number from zero to infinity that represents the absolute magnitude of the sentence sentiment regardless of score."
        },
        {
          name = "speakerTag",
          type = "INTEGER",
          mode = "NULLABLE",
          description = "The speaker that the sentence originated from."
        },
        {
          name = "languageCode",
          type = "STRING",
          mode = "NULLABLE",
          description = "Language code."
        },
        {
          name = "startOffsetNanos",
          type = "INTEGER",
          mode = "NULLABLE",
          description = "Time offset in nanoseconds of the start of this sentence relative to the beginning of the conversation."
        },
        {
          name = "endOffsetNanos",
          type = "INTEGER",
          mode = "NULLABLE",
          description = "Time offset in nanoseconds of the end of this sentence relative to the beginning of the conversation."
        },
        {
          name = "createTimeNanos",
          type = "INTEGER",
          mode = "NULLABLE",
          description = "Time in nanoseconds that the conversation message took place, if provided."
        },
        {
          name = "participantId",
          type = "STRING",
          mode = "NULLABLE",
          description = "Participant ID, if provided."
        },
        {
          name = "participantRole",
          type = "STRING",
          mode = "NULLABLE",
          description = "Participant role, if provided."
        },
        {
          name = "obfuscatedExternalUserId",
          type = "STRING",
          mode = "NULLABLE",
          description = "Obfuscated external user ID, if provided."
        },
        {
          name = "isCoveredBySmartReplyAllowlist",
          type = "BOOLEAN",
          mode = "NULLABLE",
          description = "Whether the sentence is covered by [a configured smart reply allowlist](/agent-assist/docs/model-training#model_allowlist_management) in Agent Assist."
        },
        {
          name = "annotations",
          type = "RECORD",
          mode = "REPEATED",
          description = "The list of annotations from [Dialogflow Runtime Integration](/contact-center/insights/docs/enable-dialogflow-runtime-integration). See [full list](/contact-center/insights/docs/reference/rest/v1/projects.locations.conversations#runtimeannotation).",
          fields = [
            {
              name = "annotationRecord",
              type = "JSON",
              mode = "NULLABLE",
              description = "The annotation record returned from Dialogflow."
            },
            {
              name = "createTimeNanos",
              type = "INTEGER",
              mode = "NULLABLE",
              description = "The timestamp when the suggestion was generated."
            },
            {
              name = "type",
              type = "STRING",
              mode = "NULLABLE",
              description = "The type of suggestion."
            },
            {
              name = "clicked",
              type = "BOOLEAN",
              mode = "NULLABLE",
              description = "Customer feedback on whether the suggestion was clicked."
            },
            {
              name = "correctnessLevel",
              type = "STRING",
              mode = "NULLABLE",
              description = "Customer feedback on the correctness level of the suggestion."
            },
            {
              name = "displayed",
              type = "BOOLEAN",
              mode = "NULLABLE",
              description = "Customer feedback on whether the suggestion was displayed."
            },
            {
              name = "detailedFeedback",
              type = "JSON",
              mode = "NULLABLE",
              description = "The detailed feedback content returned from Dialogflow."
            }
          ]
        },
        {
          name = "intentMatchData",
          type = "RECORD",
          mode = "REPEATED",
          description = "The list of matched intents for the sentence.",
          fields = [
            {
              name = "intentId",
              type = "STRING",
              mode = "NULLABLE",
              description = "The unique ID of the matched intent."
            },
            {
              name = "displayName",
              type = "STRING",
              mode = "NULLABLE",
              description = "The human readable name of the matched intent."
            }
          ]
        },
        {
          name = "phraseMatchData",
          type = "RECORD",
          mode = "REPEATED",
          description = "The list of phrase match data for the sentence.",
          fields = [
            {
              name = "phraseMatcherId",
              type = "STRING",
              mode = "NULLABLE",
              description = "The unique ID of the phrase matcher."
            },
            {
              name = "revisionId",
              type = "STRING",
              mode = "NULLABLE",
              description = "Indicating the revision of the phrase matcher."
            },
            {
              name = "displayName",
              type = "STRING",
              mode = "NULLABLE",
              description = "The human readable name of the phrase matcher."
            }
          ]
        },
        {
          name = "highlightData",
          type = "RECORD",
          mode = "REPEATED",
          description = "The list of highlighter data for the sentence.",
          fields = [
            {
              name = "highlighterName",
              type = "STRING",
              mode = "NULLABLE",
              description = "The unique id of the highlighter."
            },
            {
              name = "displayName",
              type = "STRING",
              mode = "NULLABLE",
              description = "The human readable name of the highlighter."
            },
            {
              name = "type",
              type = "STRING",
              mode = "NULLABLE",
              description = "The type of the highlighter."
            }
          ]
        },
        {
          name = "dialogflowIntentMatchData",
          type = "RECORD",
          mode = "REPEATED",
          description = "The list of Dialogflow intent match data for the sentence.",
          fields = [
            {
              name = "intentName",
              type = "STRING",
              mode = "NULLABLE",
              description = "The resource name of the matched intent."
            },
            {
              name = "displayName",
              type = "STRING",
              mode = "NULLABLE",
              description = "The human readable name of the matched intent."
            },
            {
              name = "maxConfidence",
              type = "FLOAT",
              mode = "NULLABLE",
              description = "The confidence score for the intent match, between 0 and 1.0."
            }
          ]
        }
      ]
    },
    {
      name = "latestSummary",
      type = "RECORD",
      mode = "NULLABLE",
      description = "The latest conversation summary.",
      fields = [
        {
          name = "text",
          type = "STRING",
          mode = "NULLABLE",
          description = "The summarization content that is concatenated into one string."
        },
        {
          name = "textSections",
          type = "RECORD",
          mode = "REPEATED",
          description = "The summarization content that is divided into sections. The key is the section's name and the value is the section's content. There is no specific format for the key or value.",
          fields = [
            {
              name = "key",
              type = "STRING",
              mode = "NULLABLE",
              description = "The name of the section."
            },
            {
              name = "value",
              type = "STRING",
              mode = "NULLABLE",
              description = "The content of the section."
            }
          ]
        },
        {
          name = "confidence",
          type = "FLOAT",
          mode = "NULLABLE",
          description = "The confidence score of the summarization."
        },
        {
          name = "metadata",
          type = "RECORD",
          mode = "REPEATED",
          description = "A map that contains metadata about the summarization and the document from which it originates.",
          fields = [
            {
              name = "key",
              type = "STRING",
              mode = "NULLABLE",
              description = "The key of the metadata."
            },
            {
              name = "value",
              type = "STRING",
              mode = "NULLABLE",
              description = "The value of the metadata."
            }
          ]
        },
        {
          name = "answerRecord",
          type = "STRING",
          mode = "NULLABLE",
          description = "The name of the answer record. Format: projects/{project}/locations/{location}/answerRecords/{answer_record}"
        },
        {
          name = "conversationModel",
          type = "STRING",
          mode = "NULLABLE",
          description = "The name of the model that generates this summary. Format: projects/{project}/locations/{location}/conversationModels/{conversation_model}"
        }
      ]
    }
  ])
}

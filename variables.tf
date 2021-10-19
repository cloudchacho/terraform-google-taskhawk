variable "apps" {
  description = "List of applications, map of app name to queue config"
  type = map(object({
    # Labels to attach to the PubSub topic and subscription
    labels = optional(map(string))

    # Threshold for alerting on high message count in main queue
    high_message_count_threshold = optional(number)

    # Threshold for alerting on high message count in high priority queue
    high_priority_high_message_count_threshold = optional(number)

    # Threshold for alerting on high message count in low priority queue
    low_priority_high_message_count_threshold = optional(number)

    # Threshold for alerting on high message count in bulk queue
    bulk_high_message_count_threshold = optional(number)

    # The duration for testing for alerting on high message count in the main queue (defaults to 5 minutes)
    high_message_count_test_duration = optional(number)

    # The duration for testing for alerting on high message count in the high priority queue (defaults to 5 minutes)
    high_message_count_high_priority_test_duration = optional(number)

    # The duration for testing for alerting on high message count in the low priority queue (defaults to 5 minutes)
    high_message_count_low_priority_test_duration = optional(number)

    # The duration for testing for alerting on high message count in the bulk queue (defaults to 5 minutes)
    high_message_count_bulk_test_duration = optional(number)

    # The IAM service accounts for this app
    service_accounts = optional(list(string))

    # Should all tasks published for this app be firehosed into Cloud Storage
    enable_firehose = optional(bool)

    # Taskhawk jobs to be run on scheduler (name should contain just a-z and hyphens)
    scheduler_jobs = optional(list(object({
      # Rule name (must be unique across all jobs)
      name = string

      # Which queue to scheduled task into? (defaults to default)
      priority = optional(string)

      # Description of the job
      description = optional(string)

      # Cloud Scheduler cron schedule expression
      schedule = string

      # Taskhawk message format version (default v1.0)
      format_version = optional(string)

      # Timezone for the schedule
      timezone = string

      # Custom headers
      headers = optional(map(string))

      # Name of the task
      task = string

      # Task args
      args = optional(list(string))

      # Task kwargs
      kwargs = optional(map(string))

      # Task kwargs encoded as a JSON string (use this to get around terraform type problems), if set this is preferred over kwargs
      kwargs_encoded = optional(string)
    })))
  }))
}

variable "enable_alerts" {
  description = "Should Stackdriver alerts be generated?"
  type        = bool
  default     = false
}

variable "enable_firehose_all_messages" {
  description = "Should all messages published to this topic be firehosed into Cloud Storage"
  default     = "false"
}

variable "dataflow_tmp_gcs_location" {
  description = "A gs bucket location for storing temporary files by Google Dataflow, e.g. gs://myBucket/tmp"
  default     = ""
}

variable "dataflow_template_gcs_path" {
  description = "The template path for Google Dataflow for PubSub to Storage, e.g. gs://dataflow-templates/2019-04-24-00/Cloud_PubSub_to_GCS_Text"
  default     = "gs://dataflow-templates/2019-04-24-00/Cloud_PubSub_to_GCS_Text"
}

variable "dataflow_zone" {
  description = "The zone to use for Dataflow. This may be required if it's not set at the provider level, or that zone doesn't support Dataflow regional endpoints (see https://cloud.google.com/dataflow/docs/concepts/regional-endpoints)"
  default     = ""
}

variable "dataflow_region" {
  description = "The region to use for Dataflow. This may be required if it's not set at the provider level, or you want to use a region different from the zone (see https://cloud.google.com/dataflow/docs/concepts/regional-endpoints)"
  default     = ""
}

variable "dataflow_output_directory" {
  description = "A gs bucket location for storing output files by Google Dataflow, e.g. gs://myBucket/taskhawkBackup"
  default     = ""
}

variable "dataflow_output_filename_prefix" {
  description = "Filename prefix for output files by Google Dataflow (defaults to subscription name)"
  default     = ""
}

variable "alerting_project" {
  description = "The project where alerting resources should be created (defaults to current project)"
  default     = ""
}

variable "dataflow_freshness_alert_threshold" {
  description = "Threshold for alerting on Dataflow freshness in seconds"
  default     = 1800 # 30 mins
}

variable "dataflow_freshness_alert_notification_channels" {
  description = "Stackdriver Notification Channels for dataflow alarm for freshness (required if alerting is on)"
  type        = list(string)
  default     = []
}

variable "dlq_alert_notification_channels" {
  default     = []
  type        = list(string)
  description = "Stackdriver Notification Channels for DLQ alarm for high message count (required if alerting is on)"
}

variable "queue_alert_notification_channels" {
  default     = []
  type        = list(string)
  description = "Stackdriver Notification Channels for main queue alarm for high message count (required if alerting is on)"
}

module "apps" {
  for_each = var.apps

  source  = "cloudchacho/taskhawk-queue/google"
  version = "~> 3.4.0"

  queue                = each.key
  iam_service_accounts = each.value.service_accounts
  scheduler_jobs       = each.value.scheduler_jobs
  labels               = each.value.labels

  enable_alerts                                          = var.enable_alerts
  alerting_project                                       = var.alerting_project
  queue_high_message_count_notification_channels         = var.queue_alert_notification_channels
  dlq_high_message_count_notification_channels           = var.dlq_alert_notification_channels
  queue_alarm_high_message_count_threshold               = each.value.high_message_count_threshold
  queue_alarm_high_priority_high_message_count_threshold = each.value.high_priority_high_message_count_threshold
  queue_alarm_low_priority_high_message_count_threshold  = each.value.low_priority_high_message_count_threshold
  queue_alarm_bulk_high_message_count_threshold          = each.value.bulk_high_message_count_threshold
  queue_alarm_test_duration_s                            = each.value.high_message_count_test_duration_s
  queue_alarm_high_priority_test_duration_s              = each.value.high_message_count_high_priority_test_duration_s
  queue_alarm_low_priority_test_duration_s               = each.value.high_message_count_low_priority_test_duration_s
  queue_alarm_bulk_test_duration_s                       = each.value.high_message_count_bulk_test_duration_s

  enable_firehose_all_messages                   = var.enable_firehose_all_messages || each.value.enable_firehose == true
  dataflow_freshness_alert_threshold             = var.dataflow_freshness_alert_threshold
  dataflow_freshness_alert_notification_channels = var.dataflow_freshness_alert_notification_channels
  dataflow_output_filename_prefix                = var.dataflow_output_filename_prefix
  dataflow_tmp_gcs_location                      = var.dataflow_tmp_gcs_location
  dataflow_template_gcs_path                     = var.dataflow_template_gcs_path
  dataflow_zone                                  = var.dataflow_zone
  dataflow_region                                = var.dataflow_region
  dataflow_output_directory                      = var.dataflow_output_directory
}

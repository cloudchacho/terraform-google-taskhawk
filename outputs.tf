output "default_topic_ids" {
  value = { for app, mod in module.apps : app => mod.default_topic_id }
}

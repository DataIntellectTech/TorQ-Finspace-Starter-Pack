
// 1. you'll need to create a metric filter to monitor the appropriate cloudwatch log group
//      it would be ideal if we could import the cloudwatch log group inform
// 2. will probably need a for-each block and count to create one metric filter per wdb log group
// 3. create an alarm for each metric filter
// 4. create an eventbridge rule for each alarm. The alarms must hit the step function defined in the "lambda" module
// 5. import the sfn arn and the eventbridge policy to allow new eventbridge to hit the sfn machine


variable "environment-id" {
  description = "import the environment_id"
}

variable "sfn_state_machine_arn" {
  description = "step function state machine to create clusters"
}

variable "eventBridge_role_arn" {
  description = "IAM role allowing eventBrige to execute step functions"
}

variable "rdbCntr_mod" {
  description = "maximum number of wdbs created by lambda"
}

locals {
    metric-filter-name = "wdb_eop_shutdown_msg"
    log-group-prefix   = "/aws/vendedlogs/finspace/${var.environment-id}"
    //wdb_cluster_names  = concat(["wdb"],[for i in range(var.rdbCntr_mod) : format("wdb%d",i+1)]) ## uncomment when ready
    wdb_cluster_names  = ["wdb","wdb1"]
}

resource "aws_cloudwatch_log_metric_filter" "wdb_log_monit" {
    for_each       = toset(local.wdb_cluster_names)
    name           = local.metric-filter-name
    pattern        = "kill the hdb"             ##hard coded for now, but eventually this should be a configurable variable
    log_group_name = "${local.log-group-prefix}/${each.value}"

    metric_transformation {
        name          = "count_eopMsg_wdb"
        namespace     = "AWSFinTorq"
        value         = "1" 
        default_value = "0"
        unit          = "Count"
    } 
}

resource "aws_cloudwatch_metric_alarm" "wdb_log_monit_alarm" {
  alarm_name = "${local.metric-filter-name}_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = aws_cloudwatch_log_metric_filter.wdb_log_monit["wdb"].metric_transformation[0].name
  namespace =   aws_cloudwatch_log_metric_filter.wdb_log_monit["wdb"].metric_transformation[0].namespace
  period = 120
  statistic = "Sum"
  threshold = 1
  alarm_description = "This alarm should raise if ${local.metric-filter-name} metric filter finds any matches"
  datapoints_to_alarm = 1
}

resource "aws_cloudwatch_event_rule" "wdb_log_monit_rule" {
  name = "${local.metric-filter-name}_rule"
  description = "trigger lambda when ${local.metric-filter-name} finds any matches"

  event_pattern = jsonencode({
    "source": ["aws.cloudwatch"],
    "detail-type": ["CloudWatch Alarm State Change"],
    "resources": ["${aws_cloudwatch_metric_alarm.wdb_log_monit_alarm.arn}"]
    "detail": {
      "state": {
        "value": ["ALARM"]
      }
    }
  })
}

resource "aws_cloudwatch_event_target" "wdb_log_monit_rule_target" {
  arn = var.sfn_state_machine_arn
  rule = aws_cloudwatch_event_rule.wdb_log_monit_rule.name
  role_arn = var.eventBridge_role_arn
    input = jsonencode({
    cluster_prefix = "hdb",
    clusterType = "HDB"
  })
}



resource "aws_sns_topic" "alarm-topic" {
  name = "cloudwatch-alarms-topic"
}

resource "aws_sns_topic_subscription" "alarm-email-subscription" {
  topic_arn = aws_sns_topic.alarm-topic.arn
  protocol  = "email"
  endpoint  = var.alarm-email
}

resource "aws_cloudwatch_metric_alarm" "cpu-utilization-alarm" {
  for_each = var.asg-names
  alarm_name          = "HighCPU-${each.key}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = var.cpu-utilization-threshold
  alarm_description   = "Alarm when CPU exceeds threshold for ASG ${each.key}"
  alarm_actions       = [aws_sns_topic.alarm-topic.arn]

  dimensions = {
    AutoScalingGroupName = each.key
  }
}

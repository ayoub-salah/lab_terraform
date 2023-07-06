resource "aws_cloudwatch_metric_alarm" "request_counter" {
  alarm_name          = "request_counter"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "RequestCount"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "SampleCount"
  threshold           = "10"
  alarm_description   = "This metric checks for more than 10 requests in one minute"
  alarm_actions       = [aws_sns_topic.request_counter.arn]
  dimensions = {
    LoadBalancer = aws_lb.ayoub_alb_1.arn_suffix
  }
}

resource "aws_sns_topic" "request_counter" {
  name = "request_counter"
}

resource "aws_sns_topic_subscription" "high_request_count_email" {
  topic_arn = aws_sns_topic.request_counter.arn
  protocol  = "email"
  endpoint  = "ayoub.salah@infraxcode.com"
}
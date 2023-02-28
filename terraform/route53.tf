# resource "aws_route53_record" "a" {
#   zone_id = "${data.aws_route53_zone._.zone_id}"
#   name    = "${var.purchased_domain}"
#   type    = "A"

#   alias {
#     name                   = "${aws_cloudfront_distribution._.domain_name}"
#     zone_id                = "${aws_cloudfront_distribution._.hosted_zone_id}"
#     evaluate_target_health = false
#   }
# }
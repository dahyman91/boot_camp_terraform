# resource "aws_acm_certificate" "_" {
#   domain_name       = var.purchased_domain
#   validation_method = "DNS"

#   tags = {
#     Environment = "test"
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# data "aws_route53_zone" "_" {
#   name  = var.purchased_domain
#   # private_zone = false
# }

# resource "aws_route53_record" "cert" {
#   for_each = {
#     for dvo in aws_acm_certificate._.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = data.aws_route53_zone._.zone_id
# }

# resource "aws_acm_certificate_validation" "_" {
#   certificate_arn         = aws_acm_certificate._.arn
#   validation_record_fqdns = [for record in aws_route53_record.cert : record.fqdn]
# }
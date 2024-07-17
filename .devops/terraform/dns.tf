resource "aws_route53_zone" "this" {
  name = "spinet.vigetx.com"
}


resource "aws_route53_record" "this" {
  for_each = toset([
    "spinet.vigetx.com",
    "*.spinet.vigetx.com"
  ])

  zone_id = aws_route53_zone.this.zone_id
  name    = each.key
  type    = "A"
  ttl     = 300

  records = [
    aws_instance.web.public_ip
  ]
}

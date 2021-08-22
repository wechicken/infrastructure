resource "aws_security_group" "allow-web" {
  vpc_id      = "${var.dmz.id}"
  name        = "Allow Web Security Group"
  description = "Allow Web Security Group"

  tags = { Name = "Allow Web Security Group" }
}

resource "aws_security_group_rule" "web-lb-http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.allow-web.id}"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "web-lb-https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.allow-web.id}"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "web-lb-http-egress" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.allow-web.id}"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "web-lb-https-egress" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.allow-web.id}"

  lifecycle { create_before_destroy = true }
}

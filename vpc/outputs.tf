output "dmz" {
  value = aws_vpc.dmz
}

output "dmz-public-2a" {
  value = aws_subnet.dmz-public-2a
}

output "dmz-public-2c" {
  value = aws_subnet.dmz-public-2c
}

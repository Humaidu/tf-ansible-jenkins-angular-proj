
output "instance_id" {
  value = aws_instance.angular_app.id
}

output "public_ip" {
  value = aws_instance.angular_app.public_ip
}
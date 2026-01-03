output "instance_id" {
  description = "Instance Id of ec2-instance"
  value       = aws_instance.example.id
}
output "public_ip" {
  description = "ec2-instance public-ip"
  value       = aws_instance.example.public_ip
}
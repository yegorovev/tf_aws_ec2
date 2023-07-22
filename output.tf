output "instance" {
  description = "EC2 instance"
  value       = aws_instance.this
}

output "route" {
  description = "Route to VM"
  value       = module.route
}

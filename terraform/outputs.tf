output "Public-ips"{
    value = aws_instance.servers.*.public_ip
}
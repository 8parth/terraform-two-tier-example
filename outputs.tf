output "vpc_id" {
    value = "${aws_vpc.customvpc.id}"
}

output "public_instance_dns" {
    value = "${aws_instance.web1.public_dns}"
}

output "private_instance_ip" {
    value = "${aws_instance.db1.private_ip}"    
}

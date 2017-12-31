resource "aws_security_group" "websg" {
    name = "vpc_web"
    description = "Allow incoming HTTP connections."
    vpc_id = "${aws_vpc.customvpc.id}"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "WebSG"
        Terraform = true
    }
}

resource "aws_instance" "web1" {
    ami = "${data.aws_ami.ubuntu.id}"
    availability_zone = "us-east-1a"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.websg.id}"]
    subnet_id = "${aws_subnet.us-east-1a-public.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags = {
        Name = "WebServer"
        Terraform = true
    }

    connection {
        type     = "ssh"
        user     = "ubuntu"
        timeout = "1m"
        private_key = "${file(var.private_key_path)}"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo apt-get update -y",
            "sudo apt-get install apache2 -y",
            "sudo service apache2 start"
        ]
    }
}

resource "aws_eip" "web1" {
    instance = "${aws_instance.web1.id}"
    vpc = true
}
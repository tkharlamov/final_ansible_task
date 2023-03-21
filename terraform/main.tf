resource "aws_security_group" "sg_exporter" {
  name = "node-exporter-access"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 9100
    protocol    = "tcp"
    to_port     = 9100
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "terraform-created"
  }
}

resource "aws_instance" "itea-machine" {
  count = 3

  ami = lookup(var.ec2_ami,var.region)
  instance_type = var.instance_type
  tags = {
    Name = "itea-machine-${count.index + 1}"
  }
  key_name = "ec2-instance-key"
  vpc_security_group_ids = [aws_security_group.sg_exporter.id]
}

# provisioner "file" {
#    source      = "install_jenkins.sh"
#    destination = "/tmp/install_jenkins.sh"
#  }
#
#  provisioner "remote-exec" {
#    inline = [
#      "chmod +x /tmp/install_jenkins.sh",
#      "sudo /bin/bash /tmp/install_jenkins.sh",
#    ]
#  }
#
#  connection {
#    type        = "ssh"
#    user        = "ubuntu"
#    password    = ""
#    private_key = file("/home/itea-user/Final_Task/ec2-instance-key.pem")
#    host        = self.public_ip
#  }
#}

resource "local_file" "tf_ip" {
  content  = "[node_exp]\n${aws_instance.itea-machine[0].public_ip} ansible_ssh_user=ubuntu ansible_ssh_private_key_file=/home/itea-user/Final_Task/ec2-instance-key.pem\n${aws_instance.itea-machine[1].public_ip} ansible_ssh_user=ubuntu ansible_ssh_private_key_file=/home/itea-user/Final_Task/ec2-instance-key.pem\n${aws_instance.itea-machine[2].public_ip} ansible_ssh_user=ubuntu ansible_ssh_private_key_file=/home/itea-user/Final_Task/ec2-instance-key.pem\nlocalhost ansible_connection=local"
  filename = "../ansible/inventory"
}

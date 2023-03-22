resource "openstack_compute_keypair_v2" "deploy_key" {
  name = "example_keypair"
}

resource "local_file" "deploy_key" {
  filename = "${path.module}/deploy_key.pem"
  content  = openstack_compute_keypair_v2.deploy_key.private_key
}

resource "openstack_compute_instance_v2" "test_terraform_instance" {
  name        = "terraform_instance"
  image_name  = "Ubuntu 22.04"
  flavor_name = "s1-2"
  key_pair    = openstack_compute_keypair_v2.deploy_key.name
  network {
    name = "Ext-Net"
  }
}

resource "null_resource" "remote_exec_provisioner" {
  triggers = {
    instance_id = openstack_compute_instance_v2.test_terraform_instance.id
  }

  provisioner "remote-exec" {
    connection {
      type  = "ssh"
      user  = "ubuntu"
      host  = openstack_compute_instance_v2.test_terraform_instance.access_ip_v4
      private_key = local_file.deploy_key.content
    }

    inline = [
      "sudo apt-get update",
      "echo lol >> lol.txt",
    ]
  }
}
/*
resource "null_resource" "local_exec_provisioner" {
  triggers = {
    instance_id = openstack_compute_instance_v2.test_terraform_instance.id
  }

  provisioner "local-exec" {
    //command = "ANSIBLE_HOST_KEY_CHECKING=False /opt/homebrew/bin/ansible-playbook -u ubuntu -i '${openstack_compute_instance_v2.test_terraform_instance.access_ip_v4},' --private-key=id_rsa ansible/apache-install.yml"
    command = "echo lol >> lol.txt"
  }
}*/

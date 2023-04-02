resource "openstack_compute_instance_v2" "test_terraform_instance" {
  name        = "terraform_instance"
  image_name  = "Ubuntu 22.04"
  flavor_name = "s1-2"
  key_pair    = "mac_m1"
  user_data = <<EOF
#cloud-config
users:
  - default
  - name: ansible
    groups: sudo
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    lock_passwd: true
    ssh_authorized_keys:
      - ${data.openstack_compute_keypair_v2.ansible_ssh_key.public_key}
EOF
  network {
    name = "Ext-Net"
  }
}


/*resource "null_resource" "local_exec_provisioner" {
  triggers = {
    instance_id = openstack_compute_instance_v2.test_terraform_instance.id
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False /opt/homebrew/bin/ansible-playbook -u ubuntu -i '${openstack_compute_instance_v2.test_terraform_instance.access_ip_v4},' ansible/apache-install.yml"
  }
}*/

###> OVH PROVIDER ###
variable ovh_application_key {
  type = string
  sensitive = true
}
variable ovh_application_secret {
  type = string
  sensitive = true
}
variable ovh_consumer_key {
  type = string
  sensitive = true
}
###< OVH PROVIDER ###

###> OPENSTACK PROVIDER ###
variable openstack_user_name {
  type = string
  sensitive = true
}
variable openstack_password {
  type = string
  sensitive = true
}
###< OPENSTACK PROVIDER ###

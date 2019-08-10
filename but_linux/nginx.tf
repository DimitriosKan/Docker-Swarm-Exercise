# - - - CREATE PRIMARY VM INSTANCE - - - 
resource "google_compute_instance" "nginx" {
	name = "${var.name}-nginx-${formatdate("DDmmss", timestamp())}"
	machine_type = "${var.machine_type}"
	zone = "${var.zone}"
	tags = ["${var.name}-nginx"]
	boot_disk {
		initialize_params {
			image = "${var.image}"
		}
	}
	network_interface {
		network = "${var.network}"
		access_config {
		
		}
	}
	metadata = {
		sshKeys = "nginx:${file("${var.public_key}")}"
	}
	connection {
		type = "ssh"
		user = "nginx"
		host = "${google_compute_instance.nginx.network_interface.0.access_config.0.nat_ip}"
		private_key = "${file("${var.private_key}")}"
	}
	provisioner "remote-exec" {
		inline = [
			"${var.update_packages[var.package_manager]}",
			"${var.install_packages[var.package_manager]} ${join(" ", var.packages)}"
		]
	}
	provisioner "file" {
		source = "scripts/swarm_setup_tutorial/nginx_swarm_script"
		destination = "/home/nginx/nginx_swarm_script"
	}
	provisioner "file" {
		source = "scripts/swarm_setup_tutorial/nginx.conf"
		destination = "/home/nginx/nginx.conf"
	}
	provisioner "remote-exec" {
		scripts = [
                  "scripts/test_script",
                  "scripts/docker_tf_script",
                  "scripts/docker-compose_tf_script"
                ]
	}
}
output "NGINX-VM" {
        value  = "ssh nginx@${google_compute_instance.nginx.network_interface.0.access_config.0.nat_ip}"
}

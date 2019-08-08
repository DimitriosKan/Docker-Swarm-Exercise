# - - - CREATE PRIMARY VM INSTANCE - - - 
resource "google_compute_instance" "worker1" {
	name = "${var.name}-worker-boi-1${formatdate("DDmmss", timestamp())}"
	machine_type = "${var.machine_type}"
	zone = "${var.zone}"
	tags = ["${var.name}"]
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
		sshKeys = "swarmboi:${file("${var.public_key}")}"
	}
	connection {
		type = "ssh"
		user = "swarmboi"
		host = "${google_compute_instance.worker1.network_interface.0.access_config.0.nat_ip}"
		private_key = "${file("${var.private_key}")}"
	}
	provisioner "remote-exec" {
		inline = [
			"${var.update_packages[var.package_manager]}",
			"${var.install_packages[var.package_manager]} ${join(" ", var.packages)}"
		]
	}
        provisioner "file" {
                source = "scripts/swarm_setup_tutorial/workernd_swarm_script"
                destination = "/home/swarmboi/workernd_swarm_script"
        }
	provisioner "remote-exec" {
		scripts = [
                  "scripts/test_script",
                  "scripts/docker_tf_script",
                  "scripts/docker-compose_tf_script"
                ]
	}
}
output "worker_name" {
        value = "${google_compute_instance.worker1.name}"
}
output "worker_ip" {
        value = "ssh swarmboi@${google_compute_instance.worker1.network_interface.0.access_config.0.nat_ip}"
}

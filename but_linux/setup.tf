variable "project" {
	default = "thenexusvm-247403"
}

variable "name" {
	default = "nexus-but"
}

variable "machine_type" {
	default = "g1-small"
}

variable "zone" {
	default = "europe-west2-c"
}

variable "image" {
	default = "ubuntu-1804-lts"
}

variable "network" {
	default = "default"
}

variable "public_key" {
	default = "~/.ssh/id_rsa.pub"
}

variable "private_key" {
	default = "~/.ssh/id_rsa"
}

variable "package_manager" {
	default = "apt"
}

variable "update_packages" {
	default = {
		"apt" = "sudo apt update && sudo apt update -y"
	}
}

variable "packages" {
	default = [
		"wget",
		"unzip"
	]
}

variable "install_packages" {
	default = {
		"apt" = "sudo apt install -y"
	}
}

variable "scripts" {
	default = []
}

variable "allowed_ports" {
	default = [
		"22",
		"80",
		"5000",
                "8080"
	]
}

# - - - CALL PROJECT - - -
provider "google" {
	credentials = "${file("~/.gcp/terraform_key.json")}"
	project	= "${var.project}"
	region	= "europe-west2"
}

#- - - Firewall setup - - -
resource "google_compute_firewall" "default" {
	name = "${var.name}-firewall"
	network = "${var.network}"
	target_tags = [
		"${var.name}-nginx",
		"${var.name}-worker",
		"${var.name}-manager"
	]
	source_ranges = ["0.0.0.0/0"]

	allow {
		protocol = "icmp"
	}

	allow {
		protocol = "tcp"
		ports = "${var.allowed_ports}"
	}
}

# resource "google_compute_firewall" "gcp-allow-rds" {
#   description        = "AWS to GCP VPC"
#   destination_ranges = []
#   direction          = "INGRESS"
#   name               = "allow-aws-connection"
#   network            = google_compute_network.vpc_network.id
#   priority           = 1000
#   project            = "gcp-test-377205"
#   source_ranges = [
#     "10.20.0.0/16",
#   ]
#   source_tags = []
#   target_tags = []

#   allow {
#     ports = [
#       "3389",
#     ]
#     protocol = "tcp"
#   }
#   allow {
#     ports    = []
#     protocol = "icmp"
#   }
# }

# resource "google_compute_firewall" "gcp-allow-iap" {
#   destination_ranges = []
#   direction          = "INGRESS"
#   name               = "allow-ingress-from-iap-mig"
#   network            = google_compute_network.vpc_network.id
#   priority           = 1000
#   project            = "gcp-test-377205"
#   source_ranges = [
#     "35.235.240.0/20",
#   ]
#   source_tags = []
#   target_tags = []

#   allow {
#     ports = [
#       "22",
#       "3389",
#     ]
#     protocol = "tcp"
#   }
# }
# Define Terraform settings and required providers
terraform {
  required_providers {
    equinix = {
      source  = "equinix/equinix"  # Specifies the Terraform provider for Equinix Metal
      version = "1.13.0"           # Specifies the version of the Equinix Metal provider
    }
  }
}

# Configure the Equinix provider
provider "equinix" {
  # Credentials for Equinix Metal resources
  # auth_token is used to authenticate with the Equinix Metal API
  auth_token = "API_key"  # Replace "API_key" with your actual Equinix Metal API key
}

# Define a resource for a dedicated Jenkins server in Equinix Metal
resource "equinix_metal_device" "jenkins_server" {
  hostname         = "jenkins-server"
  plan             = "c3.small.x86"
  metro            = "da"
  operating_system = "ubuntu_20_04"
  billing_cycle    = "hourly"
  project_id       = "project_id"
}

# Define resources for however many general purpose servers in Equinix Metal you need
resource "equinix_metal_device" "servers" {
count            = 1000  # Create 1000 instances of this resource
  hostname         = format("server-%03d", count.index + 1)
  plan             = "c3.small.x86"
  metro            = "da"
  operating_system = "ubuntu_20_04"
  billing_cycle    = "hourly"
  project_id       = "project_id"
}

# Define a resource for a VLAN within Equinix Metal
resource "equinix_metal_vlan" "vlan1" {
  description = "VLAN in Dallas"
  metro       = "da"
  project_id  = "project_id"
}

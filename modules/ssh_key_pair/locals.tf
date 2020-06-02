locals {
  public_key_filename = format("%s/%s", var.ssh_public_key_path, var.ssh_public_key_name)
}
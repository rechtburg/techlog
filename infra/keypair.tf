# Key Pair
resource "aws_key_pair" "sshkey" {
  key_name = "ssh-key"
  public_key = "${var.ssh_public_key}"
}

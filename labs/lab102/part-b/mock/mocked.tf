# this work with a empty or wrong public ip, so its not worked and echo the error
variable "emptyId" {
    default = ""
}

resource "null_resource" "check_public_ip" {
  provisioner "local-exec" {
    command = <<EOT
      if [ -z "${var.emptyId}" ]; then
        echo "ERROR: Public IP address was not assigned." >&2
        exit 1
      fi
    EOT
  }
#   depends_on = [aws_instance.vm]
}
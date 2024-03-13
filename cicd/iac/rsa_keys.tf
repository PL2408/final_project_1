resource "tls_private_key" "key_web" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_private_key" "key_agent" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_s3_object" "s3_key_web" {
  bucket       = "lopihara"
  key          = "ssh_keys/web4k"
  content      = tls_private_key.key_web.private_key_pem
  content_type = "text/plain"
}

resource "aws_s3_object" "s3_key_web_pub" {
  bucket       = "lopihara"
  key          = "ssh_keys/web4k.pub"
  content      = tls_private_key.key_web.public_key_openssh
  content_type = "text/plain"
}

resource "aws_s3_object" "s3_key_agent" {
  bucket       = "lopihara"
  key          = "ssh_keys/agent4k"
  content      = tls_private_key.key_agent.private_key_pem
  content_type = "text/plain"
}

resource "aws_s3_object" "s3_key_agent_pub" {
  bucket       = "lopihara"
  key          = "ssh_keys/agent4k.pub"
  content      = tls_private_key.key_agent.public_key_openssh
  content_type = "text/plain"
}
resource "aws_s3_object" "jenkins_server_ps1" {
  bucket = "lopihara"
  key    = "config/jenkins_server_ps1.sh"
  content = templatefile("config/ps1.sh", {
    HOSTNAME = "jenkins_server"
  })
  content_type = "text/plain"
}

resource "aws_s3_object" "jenkins_agent_ps1" {
  bucket = "lopihara"
  key    = "config/jenkins_agent_ps1.sh"
  content = templatefile("config/ps1.sh", {
    HOSTNAME = "jenkins_agent"
  })
  content_type = "text/plain"
}

resource "aws_s3_object" "web_server_ps1" {
  bucket = "lopihara"
  key    = "config/web_server_ps1.sh"
  content = templatefile("config/ps1.sh", {
    HOSTNAME = "web_server"
  })
  content_type = "text/plain"
}

resource "aws_s3_object" "update_route53_json" {
  bucket       = "lopihara"
  key          = "config/update_route53.json"
  source       = "config/update_route53.json"
  etag         = filemd5("config/update_route53.json")
  content_type = "text/plain"
}


resource "aws_s3_object" "update_route53_sh" {
  bucket       = "lopihara"
  key          = "config/update_route53.sh"
  source       = "config/update_route53.sh"
  etag         = filemd5("config/update_route53.sh")
  content_type = "text/plain"
}
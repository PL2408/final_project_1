resource "aws_s3_object" "jenkins_server_ps1" {
  bucket = "lopihara"
  key    = "config/jenkins_server_ps1.sh"
  content = templatefile("config/ps1.sh", {
    HOSTNAME = "jenkins_server"
  })
}

resource "aws_s3_object" "jenkins_agent_ps1" {
  bucket = "lopihara"
  key    = "config/jenkins_agent_ps1.sh"
  content = templatefile("config/ps1.sh", {
    HOSTNAME = "jenkins_agent"
  })
}

resource "aws_s3_object" "web_server_ps1" {
  bucket = "lopihara"
  key    = "config/web_server_ps1.sh"
  content = templatefile("config/ps1.sh", {
    HOSTNAME = "web_server"
  })
}
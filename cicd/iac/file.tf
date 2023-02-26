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

# static page files
#resource "aws_s3_object" "static_page_files" {
#  for_each     = fileset("./../../website/static_page/", "**")
#  bucket       = aws_s3_bucket.sp_bucket.id
#  key          = each.value
#  source       = "./../../website/static_page/${each.value}"
#  content_type = "text/html"
#  etag         = filemd5("./../../website/static_page/${each.value}")
#}

#resource "aws_s3_bucket_object" "s3_upload" {
#  for_each = fileset("${path.root}/build", "**/*")
#
#  bucket = "s3-upload-bucket-test"
#  key    = each.value
#  source = "${path.root}/build/${each.value}"
#
#  etag         = filemd5("${path.root}/build/${each.value}")
#  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.value), null)
#}

#https://engineering.statefarm.com/blog/terraform-s3-upload-with-mime/
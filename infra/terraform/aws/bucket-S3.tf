resource "aws_s3_bucket" "beanstalk-deploys" {
  bucket = "${var.nome}-deploys-iac"
}

resource "aws_s3_object" "docker-configs" {
  depends_on = [aws_s3_bucket.beanstalk-deploys]

  bucket = "${var.nome}-deploys-iac"
  key    = "${var.nome}.zip"
  source = "${var.nome}.zip"

  etag = filemd5("${var.nome}.zip")
}
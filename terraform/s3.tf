resource "aws_s3_bucket" "_" {
  bucket = var.purchased_domain
}

resource "aws_s3_bucket_policy" "_" {
  bucket = aws_s3_bucket._.id
  policy = data.aws_iam_policy_document._.json
}

data "aws_iam_policy_document" "_" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket._.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_website_configuration" "_" {
  bucket = aws_s3_bucket._.bucket

  index_document {
    suffix = "index.html"
  }
}


#Upload files of your static website
resource "aws_s3_bucket_object" "html" {
  for_each = fileset("../build/", "**/*.html")

  bucket = aws_s3_bucket._.bucket
  key    = each.value
  source = "../build/${each.value}"
  etag   = filemd5("../build/${each.value}")
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "svg" {
  for_each = fileset("../build/", "**/*.svg")

  bucket = aws_s3_bucket._.bucket
  key    = each.value
  source = "../build/${each.value}"
  etag   = filemd5("../build/${each.value}")
  content_type = "image/svg+xml"
}

resource "aws_s3_bucket_object" "css" {
  for_each = fileset("../build/", "**/*.css")

  bucket = aws_s3_bucket._.bucket
  key    = each.value
  source = "../build/${each.value}"
  etag   = filemd5("../build/${each.value}")
  content_type = "text/css"
}

resource "aws_s3_bucket_object" "js" {
  for_each = fileset("../build/", "**/*.js")

  bucket = aws_s3_bucket._.bucket
  key    = each.value
  source = "../build/${each.value}"
  etag   = filemd5("../build/${each.value}")
  content_type = "application/javascript"
}


resource "aws_s3_bucket_object" "images" {
  for_each = fileset("../build/", "**/*.png")

  bucket = aws_s3_bucket._.bucket
  key    = each.value
  source = "../build/${each.value}"
  etag   = filemd5("../build/${each.value}")
  content_type = "image/png"
}

resource "aws_s3_bucket_object" "json" {
  for_each = fileset("../build/", "**/*.json")

  bucket = aws_s3_bucket._.bucket
  key    = each.value
  source = "../build/${each.value}"
  etag   = filemd5("../build/${each.value}")
  content_type = "application/json"
}
# Add more aws_s3_bucket_object for the type of files you want to upload
# The reason for having multiple aws_s3_bucket_object with file type is to make sure
# we add the correct content_type for the file in S3. Otherwise website load may have issues

# Print the files processed so far
output "fileset-results" {
  value = fileset("../build/", "**/*")
}

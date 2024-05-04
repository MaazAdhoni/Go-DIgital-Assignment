resource "aws_s3_bucket" "data_processing_task_1_bucket" {
  bucket = "data-processing-task-1-bucket"
  acl    = "private"
}

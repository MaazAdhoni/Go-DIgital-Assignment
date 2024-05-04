
resource "aws_iam_role" "lambda_role" {
  name               = "lambda_execution_role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_role_attachment" {
  name       = "lambda_role_attachment"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "lambda_s3_policy" {
  name   = "lambda_s3_policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "s3:*",
        Resource = ["arn:aws:s3:::my-bucket", "arn:aws:s3:::my-bucket/*"]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_s3_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_s3_policy.arn
}



resource "aws_iam_policy_attachment" "lambda_s3_policy_attachment" {
  name       = "lambda_s3_policy_attachment"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"  
}


resource "aws_lambda_function" "my_lambda_function" {
  function_name    = "my-lambda-function"
  role             = aws_iam_role.lambda_role.arn
  handler          = "my_lambda_function.lambda_handler"
  runtime          = "python3.8"
  filename         = "D:/data-processing-task-1/my_lambda_function.zip.zip"  
}


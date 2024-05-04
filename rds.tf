resource "aws_db_instance" "my_rds_instance" {
  identifier             = "my-rds-instance"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"  
  engine_version         = "5.7"    
  instance_class         = "db.t3.micro"  
  username               = "admin"
  password               = "maazadhoni"
  publicly_accessible    = true 


   db_subnet_group_name = "new-subnet"

  
   vpc_security_group_ids = ["sg-0d69b99909c37dada"]

}

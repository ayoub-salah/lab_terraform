//EC2-Instences & ALB
resource "aws_instance" "ayoub_server_1" {
  ami           = "ami-022e1a32d3f742bd8"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.ayoub_subnet["private_subnet_1"].id
  vpc_security_group_ids = [aws_security_group.ayoub_security_group.id]
  key_name      = aws_key_pair.deployer.key_name
  associate_public_ip_address = false 
  tags = {
    Name = "ayoub_server_1"
  }
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "Hello World i'm 1 " > /var/www/html/index.html
              EOF
}

resource "aws_instance" "ayoub_server_2" {
  ami           = "ami-022e1a32d3f742bd8"  
  instance_type = "t2.micro"
  subnet_id      = aws_subnet.ayoub_subnet["private_subnet_1"].id
  vpc_security_group_ids = [aws_security_group.ayoub_security_group.id]
  key_name      = aws_key_pair.deployer.key_name
  associate_public_ip_address = false
  tags = {
    Name = "ayoub_server_2"
  }
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "Hello World i'm 2" > /var/www/html/index.html
              EOF
}



resource "aws_lb" "ayoub_alb_1" {
  name               = "ayoub-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ayoub_security_group.id]
  subnets            = [aws_subnet.ayoub_subnet["public_subnet_1"].id , aws_subnet.ayoub_subnet["public_subnet_2"].id ]
}

resource "aws_lb_target_group" "ayoub_target_group_1" {
  name     = "ayoubTargetGroup1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ayoub_vpc.id

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "ayoub_listener_1" {
  load_balancer_arn = aws_lb.ayoub_alb_1.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ayoub_target_group_1.arn
  }
}

resource "aws_lb_target_group_attachment" "ayoub_target_group_attachment_1" {
  target_group_arn = aws_lb_target_group.ayoub_target_group_1.arn
  target_id        = aws_instance.ayoub_server_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "ayoub_target_group_attachment_2" {
  target_group_arn = aws_lb_target_group.ayoub_target_group_1.arn
  target_id        = aws_instance.ayoub_server_2.id
  port             = 80
}
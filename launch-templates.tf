resource "aws_launch_template" "blue" {
  name          = "${var.project_name}-blue-template"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    data.aws_security_group.ssh.id,
    data.aws_security_group.http.id
  ]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    dnf install -y httpd
    systemctl enable httpd
    systemctl start httpd

    cat > /var/www/html/index.html <<'HTML'
    <!DOCTYPE html>
    <html>
    <head>
      <title>Blue Environment</title>
    </head>
    <body>
      <h1>Blue Environment</h1>
    </body>
    </html>
    HTML
  EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "${var.project_name}-blue-instance"
      Environment = "Blue"
    }
  }

  tags = {
    Name        = "${var.project_name}-blue-template"
    Environment = "Blue"
  }
}

resource "aws_launch_template" "green" {
  name          = "${var.project_name}-green-template"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    data.aws_security_group.ssh.id,
    data.aws_security_group.http.id
  ]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    dnf install -y httpd
    systemctl enable httpd
    systemctl start httpd

    cat > /var/www/html/index.html <<'HTML'
    <!DOCTYPE html>
    <html>
    <head>
      <title>Green Environment</title>
    </head>
    <body>
      <h1>Green Environment</h1>
    </body>
    </html>
    HTML
  EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "${var.project_name}-green-instance"
      Environment = "Green"
    }
  }

  tags = {
    Name        = "${var.project_name}-green-template"
    Environment = "Green"
  }
}

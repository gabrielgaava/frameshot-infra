resource "aws_eip" "this" {
    domain = "vpc"
  
    tags = {
      Name = "${var.vpc_name}-nat"
    }
  }
  
  resource "aws_nat_gateway" "this" {
    allocation_id = aws_eip.this.id
    subnet_id     = aws_subnet.public[0].id
  
    tags = {
      Name = "${var.vpc_name}-nat"
    }
  
    depends_on = [aws_internet_gateway.this]
  }
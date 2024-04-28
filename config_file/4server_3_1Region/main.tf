# Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Change this to your desired region
}

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create subnets in the VPC
resource "aws_subnet" "subnet_az1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet_az2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
}

# Launch instances in the subnets
resource "aws_instance" "server_az1_1" {
  ami           = "ami-0b0ea68c435eb488d" # Replace this with a valid AMI ID in us-east-1
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_az1.id
}

resource "aws_instance" "server_az1_2" {
  ami           = "ami-0b0ea68c435eb488d" # Replace this with a valid AMI ID in us-east-1
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_az1.id
}

resource "aws_instance" "server_az2" {
  ami           = "ami-0b0ea68c435eb488d" # Replace this with a valid AMI ID in us-east-1
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_az2.id
}

# Create another instance in a different region
provider "aws" {
  alias  = "us-west-2"
  region = "us-west-2" # Change this to your desired region
}

resource "aws_instance" "server_other_region" {
  provider      = aws.us-west-2
  ami           ="ami-0688ba7eeeeefe3cd"  # Replace this with a valid AMI ID in us-west-2
  instance_type = "t2.micro"
}

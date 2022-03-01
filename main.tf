# Configure the AWS Provider
provider "aws" {
  region  = "us-east-1"
}

#Define IAM user
resource "aws_iam_user" "user1" {
  name = "user1"
}
resource "aws_iam_user" "user2" {
  name = "user2"
}
resource "aws_iam_user" "user3" {
  name = "user3"
}

resource "aws_iam_group" "ec2-container-registry-power-user-group" {
    name = "ec2-container-registry-power-user-group"
}

# Assign users to group
resource "aws_iam_group_membership" "project" {
    name = "project"
    users = [
        aws_iam_user.user1.name,
        aws_iam_user.user2.name,
        aws_iam_user.user3.name
    ]
    group = aws_iam_group.ec2-container-registry-power-user-group.name
}

# Attach a policy to the group
resource "aws_iam_policy_attachment" "attachment" {
    name = "attachment"
    groups = [aws_iam_group.ec2-container-registry-power-user-group.name]
    # This allows you to specify resources using ARN format
    # arn:partition:service:region:account:resource
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  
}
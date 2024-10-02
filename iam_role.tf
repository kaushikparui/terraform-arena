####################################################
# Create an IAM role - ecsInstanceRole V2.0
####################################################

data "aws_iam_policy" "ecsInstanceRolePolicy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

data "aws_iam_policy" "ecrFullAccessPolicy" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

data "aws_iam_policy" "ssmManagedInstanceCorePolicy" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

data "aws_iam_policy_document" "ecsInstanceRolePolicy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecsInstanceRole" {
  name               = "ecsInstanceRole_tf"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ecsInstanceRolePolicy.json
}

resource "aws_iam_role_policy_attachment" "ecsInstancePolicy" {
  role       = aws_iam_role.ecsInstanceRole.name
  policy_arn = data.aws_iam_policy.ecsInstanceRolePolicy.arn
}

resource "aws_iam_role_policy_attachment" "ecrFullAccessPolicyAttach" {
  role       = aws_iam_role.ecsInstanceRole.name
  policy_arn = data.aws_iam_policy.ecrFullAccessPolicy.arn
}

resource "aws_iam_instance_profile" "ecsInstanceRoleProfile" {
  name = aws_iam_role.ecsInstanceRole.name
  role = aws_iam_role.ecsInstanceRole.name
}

resource "aws_iam_role_policy_attachment" "ssmManagedInstanceCorePolicyAttach" {
  role       = aws_iam_role.ecsInstanceRole.name
  policy_arn = data.aws_iam_policy.ssmManagedInstanceCorePolicy.arn
}

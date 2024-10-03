# ECS Cluster with EC2 Instances in Private Subnets & VPC Endpoints

This project demonstrates a setup for an Amazon ECS Cluster running EC2 instances in private subnets with VPC Endpoints for accessing AWS services securely without traversing the public internet. The architecture includes routing outside traffic into the cluster using an Application Load Balancer (ALB).

## Key Components
**1 VPC and Subnets**
      
* **VPC:** A Virtual Private Cloud that hosts all resources in a secure network.
* **Public Subnets:** Host resources such as the bastion host and ALB, allowing inbound traffic from the internet.
* **Private Subnets:** Host ECS instances to ensure they remain secure and inaccessible directly from the internet.

**2 ECS Cluster**

* **ECS with EC2 Instances:** The ECS cluster runs EC2 instances in the private subnet. Docker containers for each service are managed by the ECS agent.

**3 Bastion Host**
* The bastion host in the public subnet provides SSH access to EC2 instances in the private subnet via the private IP

**4 Application Load Balancer (ALB)**
* **ALB:** The ALB sits in front of the ECS services and routes traffic from the internet to the services running on EC2 instances in the private subnet.

* **DNS/Route 53:** Manages domain name resolution for users connecting to the services through the ALB.

**5 VPC Endpoints**
* **Endpoints:** Enable secure connections between ECS containers and AWS services like ECS, ECR, S3, and CloudWatch without the need for an internet gateway or NAT.

**6 Auto Scaling**
* **Auto Scaling:** The ECS cluster supports auto-scaling based on metrics collected by CloudWatch to ensure high availability and cost efficiency.

**7 CloudWatch and Monitoring**
* **CloudWatch:** Integrated for monitoring ECS instances and services, collecting metrics for performance and scaling.

**8 AWS Services Integrated (VPC Endpoints)**
* **ECS:** Elastic Container Service for container orchestration.
* **ECR:** Elastic Container Registry for storing Docker images.
* **S3:** Amazon Simple Storage Service for data storage & needed for ECR as the image layers will be stored in AWS backend S3 bucket.
* **CloudWatch Logs:** For logging, monitoring, and metrics.


## Diagram
(https://github.com/rdx-trippy/terraform_realm/blob/architecture-1/architecture-diagram.png?raw=true)

## License

[MIT](https://choosealicense.com/licenses/mit/)
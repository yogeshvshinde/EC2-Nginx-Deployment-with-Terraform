Connect to AWS by using AWS CLI,

AWS configure

provide AWS access key and region to deploy the resources on.


![alt text](image-13.png)

Execute the command below to check connectivity with AWS account,


aws sts get-caller-identity


![alt text](image-14.png)


Create terraform files in the project directory.



Find the latest Ubuntu 20.04 LTS AMI

![alt text](image.png)


Write the code in main.tf and variables.tf file.

Create variables.tf

![alt text](image-12.png)

Create main.tf and add AWS provider

![alt text](image-2.png)


To get the latest image of Ubuntu 20.04 LTS AMI add in the code,


![alt text](image-4.png)

For the default VPC


![alt text](image-5.png)


Create a security group

![alt text](image-6.png)

User Data Script

When EC2 boots for first time:

![alt text](image-7.png)


Create outputs.tf

![alt text](image-8.png)


Initialize terraform

terraform init


![alt text](image-9.png)

Validate Terraform

terraform validate


![alt text](image-10.png)


Execute the command to run the terraform plan and get the output in a file

terraform plan -out=tfplan


![alt text](image-15.png)



Apply the plan to execute and deploy resources to AWS,

terraform apply "tfplan"


![alt text](image-16.png)


Verify EC2

![alt text](image-17.png)


Verify Security group


![alt text](image-18.png)

Delete all resources once project is completed.

![alt text](image-19.png)

Output of the Public IP address couldn't be taken as there was some issue with AWS services after the deployment of the EC2 instance. The public Ip address was seen in the AWS portal but output couldn't be displayed.















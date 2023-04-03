# Final project 1
[LOPIHARA.IPLATINUM.PRO](https://lopihara.iplatinum.pro)

This project is a result of my way in learning DevOps tools with practical implementation.

Application is a static html Web page. Link: [lopihara.iplatinum.pro](https://lopihara.iplatinum.pro) 
It has two modes. Switching between modes is based on Route53 failover policy.
* Web site which runs on EC2 instance in Docker container - primary endpoint
* Static Web site located in S3 bucket - secondary endpoint

If web server (EC2) is up, Route53 record points to Web Server with web page marked as Dynamic. 
Otherwise Route53 points to the static web page which is located in S3 Bucket.

Project dedicated to learn DevOps technologies and implement them on real case.

## Features of the project:
1. The infrastructure is described as a code using Terraform
2. Build on a AWS platform
3. The site is launched using Docker based on Nginx image
4. Static Web site works through AWS Cloud Front
5. Jenkins is used as main CI/CD tool

Because of using AWS Free Tier this project has some limitations. 
E.g., Public Subnets where used to avoid additional costs for NAT Gateway.

![architecture diagram](cicd/iac/architecture.drawio.png)

# Hotstar Clone – Secure CI/CD Pipeline Using DevSecOps

## Project Overview

This project demonstrates the implementation of a secure CI/CD workflow for a Hotstar Clone application using DevOps and DevSecOps practices.

The objective is to automate application building, integrate security checks, containerize the application, and manage Kubernetes infrastructure.

## Technology Stack

| Area | Tools |
|---|---|
| Application | React.js, Node.js |
| CI/CD | Jenkins, GitHub |
| Containerization | Docker |
| Container Security | Trivy, Docker Scout |
| Code Quality | SonarQube |
| Dynamic Security Testing | OWASP ZAP |
| Orchestration | Kubernetes, Amazon EKS |
| Local Kubernetes | Kind |
| Infrastructure as Code | Terraform |
| Monitoring and Scaling | Kubernetes Metrics Server, HPA |

## Architecture and Workflow

1. Developer pushes application changes to GitHub.
2. Jenkins checks out the source code.
3. Jenkins verifies required tools and installs dependencies.
4. React application is built.
5. SonarQube performs code quality analysis.
6. Docker builds the application image.
7. Trivy and Docker Scout scan the container image.
8. OWASP ZAP performs a baseline security scan against the running application.
9. Kubernetes deployment and autoscaling are demonstrated using a local Kind cluster.
10. Terraform manages the existing AWS EKS managed node group.

## Jenkins Pipeline

The Jenkins pipeline has successfully executed these stages:

- Checkout
- Verify Tools
- Install Dependencies
- Build React App
- SonarQube Analysis
- Build Docker Image

## Security Scan Results

### Trivy

- Image scanned: `hotstar-clone:latest`
- Base operating system: Alpine 3.24.2
- Detected vulnerabilities: **0**

### Docker Scout

- Vulnerable packages: 1
- Remaining findings: 1 High
- Outstanding finding: `CVE-2026-107891`
- Affected package: `musl 1.2.6-r3`
- Reported fix version: `1.2.6-r6`

### OWASP ZAP

- Scan type: Baseline scan
- URLs scanned: 8
- New failures: 0
- Warnings: 4
- Passes: 58

The ZAP baseline scan is a security check, not a full penetration test.

### SonarQube

- Quality Gate: Passed
- Security rating: A
- New issues: 0
- Security hotspots: 0
- Code duplication: 0%

## Kubernetes Deployment

The application was deployed and tested on a local Kind Kubernetes cluster.

- Namespace: `hotstar-devsecops`
- Deployment: `hotstar`
- Replicas: 2
- Service: `hotstar-service`
- Service type: ClusterIP
- Container port: 8080
- Horizontal Pod Autoscaler: CPU target 50%
- Minimum replicas: 2
- Maximum replicas: 5

Autoscaling was verified under load, with the deployment scaling up to 5 replicas.

The local Kind deployment is separate from the AWS EKS infrastructure.

## AWS EKS and Terraform

An Amazon EKS cluster named `hotstar-eks` was created in the `ap-south-1` region.

Managed node group: `hotstar-workers`

- Kubernetes version: 1.37
- Instance type: `t3.small`
- Desired nodes: 2
- Minimum nodes: 2
- Maximum nodes: 3
- Capacity type: ON_DEMAND

Terraform configuration manages the existing EKS managed node group. The resource was imported into Terraform, and the latest plan reported:

`No changes. Your infrastructure matches the configuration.`

The application deployment on AWS EKS is not claimed as completed by this documentation.

## Running the Application Locally

Prerequisites:

- Node.js and npm
- Docker Desktop

Install dependencies:

```bash
npm install
```

Start the React application:

```bash
npm start
```

Build the Docker image:

```bash
docker build -t hotstar-clone:latest .
```

Run the container:

```bash
docker run --rm -p 8088:8080 hotstar-clone:latest
```

Open `http://localhost:8088` in your browser.

## Terraform Validation

From the Terraform directory:

```bash
terraform init
terraform validate
terraform plan
```

Review the plan before applying any infrastructure changes.

## Project Outcomes

- Implemented a Jenkins-based CI/CD workflow.
- Built a multi-stage Docker image.
- Applied non-root container execution and Nginx security headers.
- Integrated SonarQube code quality analysis.
- Performed Trivy and Docker Scout image scans.
- Performed OWASP ZAP baseline testing.
- Demonstrated Kubernetes deployment and horizontal autoscaling.
- Managed an existing AWS EKS node group using Terraform.

## Important Notes

- Security scan results represent the versions and configurations tested at the time of the scan.
- Docker Scout still reports one High vulnerability; it has not been hidden or marked as fixed.
- AWS resources may incur charges while running.
- Never commit AWS credentials, Terraform state files, or other secrets.

## Author

Aryapratap Nayak

MCA – Artificial Intelligence and Machine Learning

GitHub: [AryapratapNayak](https://github.com/AryapratapNayak)

# AWS execution and evidence

## 1. Create ECR repository
In your AWS account, select Mumbai (`ap-south-1`) and create a private ECR repository named `devops-lab1-app`. Allow mutable tags for this lab because the pipeline updates `latest`. Copy your own repository URI; do not reuse the account ID from the reference PDF.

## 2. Create CodeBuild project
- Name: `devops-experiment-9`.
- Source: GitHub; authorize your GitHub connection and select this repository, branch `main`.
- Environment: managed Ubuntu standard image supporting Python 3.11, EC2 compute, Linux container. Use an image with Docker and AWS CLI installed. Enable privileged mode for Docker builds.
- Service role: a dedicated CodeBuild role with the normal build/log permissions and ECR permissions described below.
- Build specification: use `buildspec.yml` in the source root.
- Artifacts: none (the output is the ECR image).
- Environment variables: `ECR_URI` = your complete repository URI; `AWS_DEFAULT_REGION` = `ap-south-1`.
- Use on-demand builds for the experiment. AWS resources can incur charges.

## 3. ECR permissions
Replace `YOUR_ACCOUNT_ID` in `iam/ecr-push-policy.json` with your AWS account ID, then attach the policy to the CodeBuild service role. Change region/repository in the ARN if you chose different values. This template supplements the role's CodeBuild source and CloudWatch Logs permissions; it is not a complete service role.

## 4. Passing build
Start a build of `main`. Verify install and lint succeed, pytest reports two passing tests, and Docker build/push succeed. Open ECR and verify both `latest` and the source commit SHA tag exist.

## 5. Failing build
Follow the intentional failure procedure in README.md. Start a build using `test-failure-demo`. Capture pytest's `assert 5 == 99` failure and the failed PRE_BUILD status. Docker build and publish must not succeed for that commit.

## Submission screenshots
1. Your GitHub repository and file list.
2. `app.py` and `test_app.py`.
3. Dockerfile and buildspec.yml.
4. ECR repository in your account.
5. CodeBuild configuration.
6. Successful build with passing tests.
7. ECR image tags for the successful commit.
8. Deliberate assertion change and failed pytest build log.

Cloud execution is pending until the project has been configured and run in your AWS account. After submission, remove lab resources you no longer need to avoid ongoing storage charges.

## Official reference
https://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html

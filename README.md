# DevOps Experiment 9: GitHub, CodeBuild, Docker and ECR

## Aim
Validate Python source with linting and unit tests, build a Docker image in AWS CodeBuild, publish it to Amazon ECR, and demonstrate that a failing test stops the build.

The supplied reference calls the app Flask, but its screenshots implement plain Python `add` and `greet` functions without Flask routes. This project follows the code shown in those screenshots. The container prints the results and exits successfully; it is not a web server.

## Files
- `app.py`: addition and greeting functions plus runnable demonstration.
- `test_app.py`: two passing unit tests.
- `requirements-dev.txt`: pinned test/lint tools.
- `Dockerfile` and `.dockerignore`: minimal Python container.
- `buildspec.yml`: test, build and push pipeline.
- `AWS_SETUP.md`: cloud setup and submission evidence steps.
- `iam/ecr-push-policy.json`: repository-scoped ECR permission template.

## Run locally
```sh
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements-dev.txt
python -m flake8 app.py test_app.py
python -m pytest -v test_app.py
python app.py
docker build -t devops-lab1-app .
docker run --rm devops-lab1-app
```

Expected: two passing tests; application output `Hello, DevOps!` and `2 + 3 = 5`.

## Intentional failure experiment
After a successful AWS build and ECR verification:
1. Create a branch `test-failure-demo` from the passing main branch.
2. In `test_app.py`, change only `assert add(2, 3) == 5` to `assert add(2, 3) == 99`.
3. Commit and push the branch, then run CodeBuild using that branch as the source version.
4. Capture the pytest assertion failure and failed PRE_BUILD phase. Lint must pass first.
5. Verify no image with this failing commit's tag was pushed to ECR.
6. Keep the main branch passing; use it for the next successful build.

Do not claim AWS execution from local test output. AWS screenshots must come from your own account and actual builds.

# Docker AWS

An ubuntu docker with all necessary installables that are required to run aws commands inside.

This is intended to be used with GitLab's CI/CD pipeline as a docker image.

## Getting Started

1. Setting up development environment

```bash
    pre-commit install
```

2. Helpful commands

```bash

# Build the docker locally
docker build -t docker-aws .

# (For debug)
docker build --progress=plain -t docker-aws .

# Run the docker locally, get into docker
docker run --name docker-aws --rm -ti docker-aws bash

```

## Usage

1. On GitLab CI

```yaml
job-build:
  image: swateekj/docker-aws:latest
  stage: build
  script: |
    echo "Your commands go here"
  rules:
    - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
```

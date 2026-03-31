# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

A minimal Ubuntu 24.04 Docker image pre-installed with AWS CLI v2 and the AWS Session Manager Plugin. Intended for use as a CI/CD base image (GitLab and GitHub Actions), published to Docker Hub as `swateekj/docker-aws`.

## Common Commands

```bash
# Build the image locally
docker build -t docker-aws .

# Build with verbose output (for debugging layer failures)
docker build --progress=plain -t docker-aws .

# Run interactively
docker run --name docker-aws --rm -ti docker-aws bash

# Verify installed tools
docker run --rm docker-aws aws --version
docker run --rm docker-aws session-manager-plugin --version
```

## Pre-commit Hooks

```bash
pre-commit install   # run once after cloning
```

Hooks enforce: YAML/JSON validity, EOF newline, trailing whitespace, no AWS credentials, no large files, no merge conflict markers.

## Release Process

Images are published automatically by the GitHub Actions workflow (`.github/workflows/docker-image.yaml`) when a semver tag is pushed:

```bash
git tag v1.2.3
git push origin v1.2.3
```

The workflow builds and pushes both a versioned tag and `:latest` to Docker Hub.

## Architecture

The `Dockerfile` is a single-stage build (the `AS build-image` alias is cosmetic — there is no second `FROM`). Tool versions are pinned as top-level `ARG` defaults and re-declared inside the build stage so they are in scope:

- `MAJOR_UBUNTU_VERSION` — Ubuntu base image version
- `AWS_CLI_VERSION` — AWS CLI v2 download version
- `SESSION_MANAGER_PLUGIN_VERSION` — Session Manager Plugin `.deb` version

When adding new versioned tools, follow this same ARG pattern and verify the pinned version against the official AWS release page before tagging a release.

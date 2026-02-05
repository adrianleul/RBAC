# RBAC (Role-Based Access Control)

Comprehensive Role-Based Access Control (RBAC) reference implementation with a Spring Boot backend and a React + Vite frontend. This repository contains two main projects:

- `rbac-backend-main/` — Java Spring Boot backend (Gradle).
- `rbac-frontend-main/` — React + TypeScript frontend (Vite).

Repository mirrors on GitHub:

- Backend: https://github.com/adrianleul/rbac-backend.git
- Frontend: https://github.com/adrianleul/rbac-frontend.git

**Status:** Ready for local development and Docker-based deployment.

----

## Table of Contents

- Project Overview
- Tech Stack
- Repository Structure
- Prerequisites
- Quick Start (local)
- Docker (compose)
- Environment & Configuration
- Running Tests & Linting
- Contributing
- License

----

## Project Overview

This repository provides a full-stack example of an RBAC system with features such as user management, roles, permissions, menus, and audit logs. It is intended as a starter kit for enterprise-style permissioned applications.

## Tech Stack

- Backend: Java, Spring Boot, Gradle. Postgres, Redis, JWT
- Frontend: React, TypeScript, Vite, Redux, Tailwind CSS
- DevOps: Docker, docker-compose

## Repository Structure

- `rbac-backend-main/` — Backend source, Gradle wrapper, Dockerfile
  - `src/main/java/` — Java source packages
  - `src/main/resources/` — application properties and DB scripts
- `rbac-frontend-main/` — Frontend source, Vite config, Dockerfile
  - `src/` — React app source
  - `Public/` — static assets
- `docker-compose.yml` — Orchestrates backend and frontend containers

## Prerequisites

- Docker & docker-compose (recommended)
- JDK 17+ (if running backend locally without Docker)
- Node.js 16+ and npm/yarn (if running frontend locally)

## Quick Start — Local (development)

1. Backend (local):

```bash
cd rbac-backend-main
./gradlew bootRun
# or build and run the jar
./gradlew build
java -jar build/libs/*-SNAPSHOT.jar
```

2. Frontend (local):

```bash
cd rbac-frontend-main
npm install
npm run dev
# open http://localhost:5173 (or printed Vite URL)
```

Notes:
- Backend default port is typically `8080` (verify in `rbac-backend-main/src/main/resources/application.properties`).
- Frontend Vite default port is `5173`.

Default credentials (initial):

- Username: `admin`
- Password: `admin123`

For security, change these credentials immediately after first login or when deploying to production.

## Docker (Recommended)

To run both services quickly using Docker Compose:

```bash
docker-compose up --build
```

This will build and start backend and frontend containers as configured in `docker-compose.yml` at the repository root.

To run in detached mode:

```bash
docker-compose up -d --build
```

To stop and remove containers:

```bash
docker-compose down
```

## Environment & Configuration

- Backend config files: `rbac-backend-main/src/main/resources/application.properties` (and environment-specific profiles)
- Frontend config: `rbac-frontend-main/env.ts` and `rbac-frontend-main/src/utils/config.ts` (or similar)
- Database configuration and migration scripts are in backend resources (`src/main/resources/db/`)

When running with Docker, sensitive values should be provided via environment variables or a Docker secrets mechanism. Check `docker-compose.yml` for variable names.

## Running Tests & Linting

- Backend unit tests: `cd rbac-backend-main && ./gradlew test`
- Frontend tests/lint (if configured): `cd rbac-frontend-main && npm run test` or `npm run lint`

Add or update test commands in respective subproject package/gradle configs if needed.

## Contributing

Contributions are welcome. Suggested workflow:

1. Fork the repo and create a feature branch.
2. Write tests for your changes where applicable.
3. Ensure linting and tests pass locally.
4. Create a pull request with a clear description of changes.

Coding conventions:
- Keep frontend components small and reusable.
- Follow existing backend package structure and service/controller layering.

## Deployment

This repo can be deployed using Docker images from the provided Dockerfiles. For production, ensure:
- Correct production profile/environment variables for Spring Boot
- Build frontend with `npm run build` and serve with a static server or Nginx
- Use a managed database and apply migration scripts before starting services

## Where to look next

- Backend main entry: `rbac-backend-main/src/main/java/` — Spring Boot app & controllers
- Frontend main entry: `rbac-frontend-main/src/main.tsx` or `rbac-frontend-main/src/main.jsx`

## License

This project includes a `LICENSE` file in the backend directory. Verify license compatibility before reuse or redistribution.

----

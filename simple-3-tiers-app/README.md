# Simple 3-Tier Application

A basic three-tier application designed for practicing Cloud and DevOps tools, deployments, and infrastructure management.

## Architecture

- **Frontend**: Nginx serving static HTML/CSS/JS
- **Backend**: Node.js Express server
- **Database**: MySQL

## Components

1. **Frontend**
   - Simple web interface showing visit counter
   - Nginx for serving static content
   - Communicates with backend via REST API

2. **Backend**
   - Express.js server
   - Handles database operations
   - Provides REST API endpoints
   - CORS enabled for frontend communication

3. **Database**
   - MySQL database
   - Single table tracking visit counts

## Usage

This project is specifically designed for practicing:
- Container deployments (Docker)
- Orchestration (Kubernetes)
- Cloud deployments (AWS, GCP, Azure)
- CI/CD pipelines
- Infrastructure as Code
- Monitoring and logging
- Load balancing and scaling

## Environment Variables

### Frontend
- `BACKEND_DNS`: Backend service hostname
- `BACKEND_PORT`: Backend service port

### Backend
- `PORT`: Server port (default: 3000)
- `DB_HOST`: Database hostname
- `DB_PORT`: Database port (default: 3306)
- `DB_USER`: Database user
- `DB_PASS`: Database password
- `DB_NAME`: Database name

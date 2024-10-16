#!/bin/bash

# Define project name
PROJECT_NAME="multi-tenant-app"

# Step 1: Create project directory
echo "Creating project directory..."
mkdir -p $PROJECT_NAME
cd $PROJECT_NAME

# Step 2: Create server-side structure
echo "Creating server-side structure..."
mkdir -p server/{config,controllers,middleware,models,routes,services,tests}

# Create empty files in the server directory
touch server/server.js
touch server/.env
touch server/config/db.js
touch server/controllers/authController.js
touch server/middleware/authMiddleware.js
touch server/models/User.js
touch server/routes/authRoutes.js
touch server/services/emailService.js
touch server/tests/authController.test.js

# Step 3: Create client-side structure
echo "Creating client-side structure..."
mkdir -p client/public client/src/{components,services}

# Create empty files in the client directory
touch client/public/index.html
touch client/src/App.js
touch client/src/components/TenantDashboard.js
touch client/src/components/UserProfile.js
touch client/src/services/apiService.js

# Step 4: Create shared folder for shared modules and utils
echo "Creating shared folder..."
mkdir -p shared/{constants,utils,types}

# Create empty files in the shared directory
touch shared/constants/constants.js
touch shared/utils/formatUtils.js
touch shared/types/index.js

# Step 5: Initialize Git (optional)
echo "Initializing Git repository..."
git init

echo "Project structure has been created!"


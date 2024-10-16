#!/bin/bash

# Define variables
PROJECT_NAME="multi-tenant-app-with-code"
MONGO_DB_NAME="multitenantdb"
NODE_VERSION="14"  # Specify the Node.js version to use
PORT="3000"

# Step 1: Install system dependencies
echo "Installing system dependencies..."
sudo apt update && sudo apt install -y curl git build-essential

# Step 2: Install Node.js
echo "Installing Node.js version $NODE_VERSION..."
curl -fsSL https://deb.nodesource.com/setup_$NODE_VERSION.x | sudo -E bash -
sudo apt install -y nodejs

# Step 3: Create project directory
echo "Setting up project directory..."
mkdir $PROJECT_NAME && cd $PROJECT_NAME

# Step 4: Initialize Node.js project
echo "Initializing Node.js project..."
npm init -y

# Step 5: Install required npm packages
echo "Installing required npm packages..."
npm install express mongoose jsonwebtoken bcryptjs dotenv nodemailer passport passport-google-oauth20 jest --save

# Step 6: Set up directory structure
echo "Setting up project structure..."
mkdir -p server/{config,controllers,middleware,models,routes,services,tests}
mkdir -p client/public client/src/components client/src/services
mkdir -p shared/{constants,utils,types}

# Step 7: Initialize Git
echo "Initializing Git repository..."
git init

# Step 8: Create environment variables file (.env)
echo "Creating environment file (.env)..."
cat <<EOT >> server/.env
# Environment Variables
PORT=$PORT
MONGO_URI=mongodb://localhost:27017/$MONGO_DB_NAME
JWT_SECRET=$(openssl rand -base64 32)
GOOGLE_CLIENT_ID=your-google-client-id
GOOGLE_CLIENT_SECRET=your-google-client-secret
EOT

# Step 9: Create basic files for server
echo "Creating basic server files..."

# server.js - Entry point
cat <<EOT >> server/server.js
const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv');
const authRoutes = require('./routes/authRoutes');

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

mongoose.connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('Connected to MongoDB'))
  .catch(err => console.error('MongoDB connection error:', err));

app.use(express.json());
app.use('/api/auth', authRoutes);

app.listen(PORT, () => {
  console.log(\`Server running on port \${PORT}\`);
});
EOT

# Create authRoutes.js
cat <<EOT >> server/routes/authRoutes.js
const express = require('express');
const { login, signup } = require('../controllers/authController');
const router = express.Router();

router.post('/login', login);
router.post('/signup', signup);

module.exports = router;
EOT

# Create authController.js
cat <<EOT >> server/controllers/authController.js
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const User = require('../models/User');

// User Login
exports.login = async (req, res) => {
  const { email, password } = req.body;
  const user = await User.findOne({ email });
  
  if (!user || !bcrypt.compareSync(password, user.passwordHash)) {
    return res.status(401).send('Invalid credentials');
  }

  const token = jwt.sign({ id: user._id, tenant: user.tenant }, process.env.JWT_SECRET, { expiresIn: '1h' });
  res.send({ token });
};

// User Signup
exports.signup = async (req, res) => {
  const { email, password, tenantId } = req.body;
  
  const passwordHash = bcrypt.hashSync(password, 10);
  const newUser = new User({ email, passwordHash, tenant: tenantId });
  
  await newUser.save();
  res.status(201).send('User created');
};
EOT

# Create User model
cat <<EOT >> server/models/User.js
const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  email: { type: String, required: true, unique: true },
  passwordHash: { type: String, required: true },
  tenant: { type: mongoose.Schema.Types.ObjectId, ref: 'Tenant' },
});

module.exports = mongoose.model('User', userSchema);
EOT

# Step 10: Set up MongoDB (Assuming MongoDB is already installed)
echo "Setting up MongoDB..."
mongo <<EOF
use $MONGO_DB_NAME
db.createCollection('users')
EOF

# Step 11: Create basic React files (client-side)
echo "Creating basic React client files..."

# App.js
cat <<EOT >> client/src/App.js
import React from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';
import TenantDashboard from './components/TenantDashboard';
import UserProfile from './components/UserProfile';

function App() {
  return (
    <Router>
      <Switch>
        <Route path="/dashboard" component={TenantDashboard} />
        <Route path="/profile" component={UserProfile} />
      </Switch>
    </Router>
  );
}

export default App;
EOT

# TenantDashboard.js
cat <<EOT >> client/src/components/TenantDashboard.js
import React from 'react';

function TenantDashboard() {
  return (
    <div>
      <h1>Tenant Dashboard</h1>
    </div>
  );
}

export default TenantDashboard;
EOT

# UserProfile.js
cat <<EOT >> client/src/components/UserProfile.js
import React from 'react';

function UserProfile() {
  return (
    <div>
      <h1>User Profile</h1>
    </div>
  );
}

export default UserProfile;
EOT

# Step 12: Run the project
echo "All done! Now you can run the server using: cd server && npm start"
echo "To run the client, navigate to the client directory and set up React: cd client && npm start"

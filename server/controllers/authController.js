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

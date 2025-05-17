require('dotenv').config();
const express = require('express');
const cors = require('cors');
const authRoutes = require('./routes/auth.routes');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes - Đảm bảo base path khớp với client
app.use('/api/v1/auth', authRoutes); 

// Health check
app.get('/', (req, res) => {
  res.send('HNCG Party Backend is running');
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
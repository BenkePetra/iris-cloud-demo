const express = require('express');
const dotenv = require('dotenv');
const authRoutes = require('./routes/auth');
const authenticateToken = require('./middleware/authMiddleware');
const pool = require('./db/pool');

dotenv.config();
const app = express();
app.use(express.json());

// Auth útvonalak
app.use('/', authRoutes);

// Védett végpont: /projects
app.get('/projects', authenticateToken, async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM project.file');
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch projects' });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`API running on http://localhost:${PORT}`);
});
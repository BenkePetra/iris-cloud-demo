import express from 'express';
import dotenv from 'dotenv';
import authRoutes from './routes/auth.js';
import authenticateToken from './middleware/authMiddleware.js';
import pool from './db/pool.js';

dotenv.config();

const app = express();
app.use(express.json());

app.use((req, res, next) => {
  res.setHeader('Content-Type', 'application/json; charset=utf-8');
  next();
});

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

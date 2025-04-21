import express from 'express'
import pkg from 'pg'
import dotenv from 'dotenv'
dotenv.config()

const { Pool } = pkg
const app = express()
app.use(express.json())

const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
})

app.get('/projects', async (req, res) => {
  const result = await pool.query('SELECT * FROM projects')
  res.json(result.rows)
})

app.post('/projects', async (req, res) => {
  const { name, owner } = req.body
  await pool.query('INSERT INTO projects (name, owner) VALUES ($1, $2)', [name, owner])
  res.status(201).send('Created')
})

app.listen(3000, () => {
  console.log('API running on http://localhost:3000')
})
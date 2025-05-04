-- Schema: system
CREATE SCHEMA IF NOT EXISTS system;
CREATE TABLE IF NOT EXISTS system.user (
  id SERIAL PRIMARY KEY,
  username VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  email VARCHAR(255)
);

-- Schema: partner
CREATE SCHEMA IF NOT EXISTS partner;
CREATE TABLE IF NOT EXISTS partner.partner (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  short_name VARCHAR(100),
  type VARCHAR(50)
);
CREATE TABLE IF NOT EXISTS partner.contact (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  email VARCHAR(255),
  phone VARCHAR(50),
  partner_id INT REFERENCES partner.partner(id)
);

-- Schema: project
CREATE SCHEMA IF NOT EXISTS project;
CREATE TABLE IF NOT EXISTS project.file (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  partner_id INT REFERENCES partner.partner(id),
  revenue NUMERIC(12,2),
  priority VARCHAR(50),
  state VARCHAR(50)
);
CREATE TABLE IF NOT EXISTS project.file_state (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

-- Schema: cmdb
CREATE SCHEMA IF NOT EXISTS cmdb;
CREATE TABLE IF NOT EXISTS cmdb.entity (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  type VARCHAR(100),
  status VARCHAR(50)
);

-- Dummy adatok
INSERT INTO system.user (username, password, email) VALUES
('demo', '$2b$10$123456789012345678901uJhQypmIs0zMgOaEqLo2twzZ.m6Bz9/S', 'demo@example.com');

INSERT INTO partner.partner (name, short_name, type) VALUES
('Demo Kft.', 'DEMO', 'vevo');

INSERT INTO partner.contact (name, email, phone, partner_id) VALUES
('Kovacs Istvan', 'kovacs@example.com', '+36123456789', 1);

INSERT INTO project.file_state (name) VALUES
('Létrehozva'), ('Futó'), ('Lezárva');

INSERT INTO project.file (name, partner_id, revenue, priority, state) VALUES
('Infrastruktúra bővítés', 1, 2500000.00, 'Magas', 'Futó');

INSERT INTO cmdb.entity (name, type, status) VALUES
('HP ProLiant DL380', 'Szerver', 'Használatban');

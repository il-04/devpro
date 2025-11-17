-- Create a database
CREATE DATABASE blog_app;
USE blog_app;

-- Table for login users
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100)
);

-- Insert sample users
INSERT INTO users (username, password, email) VALUES
('student', 'pass123', 'student@example.com'),
('admin', 'admin123', 'admin@example.com'),
('guest', 'guest123', 'guest@example.com');

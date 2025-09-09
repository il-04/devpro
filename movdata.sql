-- Create the database
DROP DATABASE IF EXISTS CineMax;
CREATE DATABASE CineMax;
USE CineMax;

-- Users table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    phone_number VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Movies table
CREATE TABLE Movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    duration_minutes INT,
    release_date DATE,
    genre VARCHAR(50),
    director VARCHAR(100),
    cast TEXT,
    rating DECIMAL(3,1),
    poster_url VARCHAR(255),
    trailer_url VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Theaters table
CREATE TABLE Theaters (
    theater_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50),
    zip_code VARCHAR(20),
    contact_number VARCHAR(20),
    total_screens INT,
    facilities TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Screens table (individual screens in theaters)
CREATE TABLE Screens (
    screen_id INT AUTO_INCREMENT PRIMARY KEY,
    theater_id INT NOT NULL,
    screen_number INT NOT NULL,
    seating_capacity INT NOT NULL,
    screen_type ENUM('Standard', 'IMAX', '3D', '4DX', 'Dolby') DEFAULT 'Standard',
    FOREIGN KEY (theater_id) REFERENCES Theaters(theater_id) ON DELETE CASCADE,
    UNIQUE KEY (theater_id, screen_number)
);

-- Showtimes table
CREATE TABLE Showtimes (
    showtime_id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT NOT NULL,
    screen_id INT NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    price DECIMAL(8,2) NOT NULL,
    available_seats INT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (screen_id) REFERENCES Screens(screen_id) ON DELETE CASCADE
);

-- Bookings table
CREATE TABLE Bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    showtime_id INT NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    payment_status ENUM('Pending', 'Completed', 'Failed', 'Refunded') DEFAULT 'Pending',
    payment_method VARCHAR(50),
    transaction_id VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (showtime_id) REFERENCES Showtimes(showtime_id) ON DELETE CASCADE
);

-- Seats table (for each booking)
CREATE TABLE Seats (
    seat_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    seat_number VARCHAR(10) NOT NULL,
    seat_type ENUM('Standard', 'Premium', 'VIP') DEFAULT 'Standard',
    price DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id) ON DELETE CASCADE
);

-- Reviews table
CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id) ON DELETE CASCADE
);

-- Insert sample data for movies (matching the frontend)
INSERT INTO Movies (title, description, duration_minutes, genre, rating, poster_url, is_active)
VALUES
('Dune: Part Two', 'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.', 166, 'Sci-Fi', 4.8, 'https://via.placeholder.com/300x450?text=Dune+Part+Two', TRUE),
('The Batman', 'When a sadistic serial killer begins murdering key political figures in Gotham, Batman is forced to investigate.', 176, 'Action', 4.6, 'https://via.placeholder.com/300x450?text=The+Batman', TRUE),
('No Time To Die', 'James Bond has left active service. His peace is short-lived when Felix Leiter, an old friend from the CIA, turns up asking for help.', 163, 'Action', 4.5, 'https://via.placeholder.com/300x450?text=No+Time+To+Die', TRUE),
('Avatar: The Way of Water', 'Jake Sully lives with his newfound family formed on the extrasolar moon Pandora.', 192, 'Sci-Fi', 4.7, 'https://via.placeholder.com/300x450?text=Avatar+2', TRUE),
('Black Panther: Wakanda Forever', 'The people of Wakanda fight to protect their home from intervening world powers as they mourn the death of King T''Challa.', 161, 'Action', 4.4, 'https://via.placeholder.com/300x450?text=Black+Panther+2', TRUE),

-- Insert sample theaters
INSERT INTO Theaters (name, location, city, state, zip_code, contact_number, total_screens)
VALUES
('CineMax Downtown', '123 Main Street', 'Metropolis', 'CA', '90210', '555-123-4567', 8),
('CineMax Westside', '456 Oak Avenue', 'Metropolis', 'CA', '90211', '555-234-5678', 6),
('CineMax East Mall', '789 Pine Road', 'Metropolis', 'CA', '90212', '555-345-6789', 10);

-- Insert screens for theaters
INSERT INTO Screens (theater_id, screen_number, seating_capacity, screen_type)
VALUES
(1, 1, 200, 'Standard'),
(1, 2, 150, 'IMAX'),
(1, 3, 180, '3D'),
(2, 1, 220, 'Standard'),
(2, 2, 120, '4DX'),
(3, 1, 250, 'Standard'),
(3, 2, 200, 'Dolby'),
(3, 3, 180, 'IMAX');

-- Insert sample showtimes (now with correct references)
INSERT INTO Showtimes (movie_id, screen_id, start_time, end_time, price, available_seats)
VALUES
(1, 1, '2023-06-15 10:00:00', '2023-06-15 12:46:00', 12.99, 200),
(1, 2, '2023-06-15 13:00:00', '2023-06-15 15:46:00', 18.99, 150),
(2, 3, '2023-06-15 11:30:00', '2023-06-15 14:26:00', 14.99, 180),
(3, 4, '2023-06-15 15:00:00', '2023-06-15 17:43:00', 12.99, 220),
(4, 5, '2023-06-15 16:30:00', '2023-06-15 19:42:00', 19.99, 120),
(5, 6, '2023-06-15 18:00:00', '2023-06-15 20:41:00', 13.99, 250),
(6, 7, '2023-06-15 19:30:00', '2023-06-15 21:40:00', 15.99, 200),
(6, 8, '2023-06-15 21:00:00', '2023-06-15 23:10:00', 15.99, 180);

-- Insert sample user
INSERT INTO Users (username, email, password_hash, full_name, phone_number)
VALUES
('john_doe', 'john@example.com', '$2a$10$xJwL5v5Jz7t6VhD5U5QZ1.ZY5rX5X5X5X5X5X5X5X5X5X5X5X5X5X', 'John Doe', '555-123-4567');

-- Insert sample booking
INSERT INTO Bookings (user_id, showtime_id, total_amount, payment_status, payment_method)
VALUES
(1, 1, 25.98, 'Completed', 'Credit Card');

-- Insert sample seats for booking
INSERT INTO Seats (booking_id, seat_number, seat_type, price)
VALUES
(1, 'A12', 'Standard', 12.99),
(1, 'A13', 'Standard', 12.99);

-- Insert sample review
INSERT INTO Reviews (user_id, movie_id, rating, review_text)
VALUES
(1, 1, 5, 'Amazing movie! The visuals were stunning and the story was compelling.');

-- Check database exists
SHOW DATABASES;

-- Use the database
USE CineMax;

-- Check tables were created
SHOW TABLES;

-- Verify sample data
SELECT * FROM Movies;
SELECT * FROM Theaters;
SELECT * FROM Screens;
SELECT * FROM Showtimes;


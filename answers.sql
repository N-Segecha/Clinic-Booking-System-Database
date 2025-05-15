CREATE DATABASE clinicDB;
USE clinicDB;
-- Create Specialties Table
CREATE TABLE specialties (
    specialty_id INT AUTO_INCREMENT PRIMARY KEY,
    specialty_name VARCHAR(100) UNIQUE NOT NULL
);

-- Create Patients Table
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other'),
    phone VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Doctors Table
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialty_id INT NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    hire_date DATE NOT NULL,
    FOREIGN KEY (specialty_id) REFERENCES specialties(specialty_id) ON DELETE RESTRICT
);

-- Create Appointments Table
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('scheduled', 'completed', 'canceled') DEFAULT 'scheduled',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE
);

-- Create Prescriptions Table
CREATE TABLE prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    medication VARCHAR(100) NOT NULL,
    dosage VARCHAR(50),
    duration VARCHAR(50),
    instructions TEXT,
    prescribed_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id) ON DELETE CASCADE
);

/********************
 SAMPLE DATA INSERTION
********************/

-- Reset auto-increment counters (optional)
ALTER TABLE specialties AUTO_INCREMENT = 1;
ALTER TABLE patients AUTO_INCREMENT = 1;
ALTER TABLE doctors AUTO_INCREMENT = 1;

-- Insert Medical Specialties
INSERT INTO specialties (specialty_name) VALUES
('Cardiology'),
('Pediatrics'),
('Neurology'),
('Orthopedics'),
('Dermatology');

-- Insert Doctors
INSERT INTO doctors (first_name, last_name, specialty_id, phone, email, hire_date) VALUES
('Emily', 'Carter', 1, '912-345678', 'ecarter@clinic.com', '2018-06-15'),
('James', 'Wilson', 2, '456-789123', 'jwilson@clinic.com', '2020-02-10'),
('Sarah', 'Johnson', 3, '789-123456', 'sjohnson@clinic.com', '2019-11-01');

-- Insert Patients
INSERT INTO patients (first_name, last_name, date_of_birth, gender, phone, email, address) VALUES
('John', 'Merkel', '1985-03-15', 'Male', '123-456789', 'john.merkel@gmail.com', '123 Main St, City'),
('Jane', 'Smith', '1990-07-22', 'Female', '345-678912', 'jane.smith@gmail.com', '456 Oak Ave, Town'),
('Brian', 'Brown', '1978-11-05', 'Other', '678-912345', 'brian.brown@gmail.com', '789 Pine Rd, Village');

-- Insert Appointments
INSERT INTO appointments (patient_id, doctor_id, appointment_date, status, notes) VALUES
(1, 1, '2023-10-15 09:00:00', 'completed', 'Routine heart checkup'),
(2, 2, '2023-10-16 10:30:00', 'scheduled', 'Child vaccination'),
(3, 3, '2023-10-17 14:00:00', 'canceled', 'Migraine follow-up'),
(1, 1, '2023-11-01 11:00:00', 'scheduled', 'Blood pressure review');

-- Insert Prescriptions
INSERT INTO prescriptions (appointment_id, medication, dosage, duration, instructions) VALUES
(1, 'Amlodipine', '5mg', '30 days', 'Take once daily at bedtime'),
(1, 'Atorvastatin', '20mg', '30 days', 'Take with evening meal'),
(2, 'Amoxicillin', '500mg', '10 days', 'Three times daily after meals');
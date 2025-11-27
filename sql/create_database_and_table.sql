-- Create a database
CREATE DATABASE public_transport;

-- Create daily passengers table
CREATE TABLE daily_passengers (
    tanggal DATE,
    jenis_moda VARCHAR(50),
    jumlah_penumpang_per_hari INT
);

-- Create halte transjakarta table
CREATE TABLE halte_transjakarta (
	wilayah VARCHAR(50),
    kecamatan VARCHAR(50),
    kelurahan VARCHAR(50),
    nama_halte VARCHAR(100),
    lokasi VARCHAR(100)
);

-- Import data table with file csv

-- Check daily passengers table
DESCRIBE daily_passengers;
SELECT * FROM daily_passengers LIMIT 50;

-- Check halte transjakarta table
DESCRIBE halte_transjakarta;
SELECT * FROM halte_transjakarta LIMIT 50;
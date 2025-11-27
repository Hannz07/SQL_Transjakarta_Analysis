-- QUESTIONS
SELECT * FROM daily_passengers ORDER BY tanggal LIMIT 50;
-- 1. List the types of public transportation in the daily passengers data table!

SELECT DISTINCT 
	jenis_moda
FROM 
	daily_passengers
ORDER BY
	jenis_moda;

-- 2. What is the total number of passengers for each type of public transportation?

SELECT
	jenis_moda,
    SUM(jumlah_penumpang_per_hari) AS total_penumpang
FROM
	daily_passengers
GROUP BY
	jenis_moda
ORDER BY
	total_penumpang DESC;

-- 3. How does the number of passengers for MRT, KRL and LRT transportation compare in 2024?

SELECT
	YEAR(tanggal) AS tahun,
    jenis_moda,
    SUM(jumlah_penumpang_per_hari) AS total_penumpang
FROM
	daily_passengers
WHERE
	YEAR(tanggal) = 2024
    AND jenis_moda IN ('MRT', 'LRT', 'KRL')
GROUP BY
    jenis_moda,
    YEAR(tanggal)
ORDER BY
	total_penumpang DESC;

-- 4. Create a running total for each year for the transjakarta public transportation mode!

WITH total_tahunan AS (
	SELECT
		YEAR(tanggal) AS tahun,
        jenis_moda,
        SUM(jumlah_penumpang_per_hari) AS total_penumpang_per_tahun
	FROM
		daily_passengers
	GROUP BY
        YEAR(tanggal),
        jenis_moda
)

SELECT
    tahun,
    jenis_moda,
    total_penumpang_per_tahun,
    SUM(total_penumpang_per_tahun) OVER (
		ORDER BY tahun
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	) AS running_total
FROM
	total_tahunan
WHERE
	jenis_moda = 'Transjakarta'
ORDER BY
	tahun;

-- 5. What is the trend for monthly transjakarta passengers in 2025?

WITH total_bulanan_2025 AS (
	SELECT
		MONTH(tanggal) AS bulan,
        jenis_moda,
        SUM(jumlah_penumpang_per_hari) AS total_penumpang_per_bulan
	FROM
		daily_passengers
	WHERE
		YEAR(tanggal) = 2025
	GROUP BY
        MONTH(tanggal),
        jenis_moda
)

SELECT
    bulan,
    jenis_moda,
    total_penumpang_per_bulan
FROM
	total_bulanan_2025
WHERE
	jenis_moda = 'Transjakarta'
ORDER BY
	bulan;

-- 6. Count the number of transjakarta bus stops by region!

SELECT
	wilayah,
    COUNT(wilayah) AS total_halte
FROM
	halte_transjakarta
GROUP BY
	wilayah
ORDER BY
	total_halte DESC;

-- 7. List the subdistricts that have more than 10 transjakarta bus stops!

SELECT
	wilayah,
    kecamatan,
    COUNT(kecamatan) AS total_halte_per_kecamatan
FROM
	halte_transjakarta
GROUP BY
	wilayah,
    kecamatan
HAVING
	total_halte_per_kecamatan > 10
ORDER BY
	total_halte_per_kecamatan DESC;

-- 8. List the names of transjakarta bus stops in the Setiabudi subdistrict!

SELECT
	nama_halte
FROM
	halte_transjakarta
WHERE
	kecamatan = 'Setiabudi'
ORDER BY
	nama_halte;




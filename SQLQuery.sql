
-- 1. CEK STRUKTUR AWAL TABEL
EXEC sp_help sales_transactions_dirty;  -- Melihat tipe data & struktur kolom
SELECT TOP 10 * FROM sales_transactions_dirty; -- Sampling data awal



-- 2. PERBAIKAN TIPE DATA
-- Ubah tipe kolom quantity dan price menjadi integer
ALTER TABLE sales_transactions_dirty
ALTER COLUMN quantity INT;

ALTER TABLE sales_transactions_dirty
ALTER COLUMN price INT;



-- 3. NORMALISASI TEKS
-- Mengubah customer_name & city menjadi lowercase, hilangkan spasi depan/belakang
UPDATE sales_transactions_dirty
SET customer_name = LTRIM(RTRIM(LOWER(customer_name)));

UPDATE sales_transactions_dirty
SET city = LTRIM(RTRIM(LOWER(city)));



-- 4. HANDLE NILAI TIDAK VALID PADA QUANTITY
-- Mengubah quantity negatif menjadi NULL
UPDATE sales_transactions_dirty
SET quantity = NULL
WHERE quantity < 0;



-- 5. STANDARISASI KOLOM DISCOUNT
-- Cek nilai discount sebelum update
SELECT
    discount,
    CASE
        WHEN discount IS NULL THEN 0
        WHEN discount LIKE '%\%%' ESCAPE '\' 
            THEN CAST(REPLACE(discount, '%', '') AS DECIMAL(5,2)) / 100
        ELSE CAST(discount AS DECIMAL(5,2))
    END AS discount_clean
FROM sales_transactions_dirty;

-- Update permanen kolom discount: ubah format % menjadi desimal
UPDATE sales_transactions_dirty
SET discount = CAST(
                    (CAST(REPLACE(discount, '%', '') AS DECIMAL(5,2)) / 100)
                AS DECIMAL(5,2))
WHERE discount LIKE '%\%%' ESCAPE '\';



-- 6. HAPUS DUPLIKAT DATA
WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY transaction_date, customer_name, email, product_name, quantity, price, discount
               ORDER BY transaction_id
           ) AS rn
    FROM sales_transactions_dirty
)
DELETE FROM cte
WHERE rn > 1;



-- 7. HANDLE NILAI NULL PADA EMAIL
UPDATE sales_transactions_dirty
SET email = 'unknown'
WHERE email IS NULL;



-- 8. CEK HASIL AKHIR
SELECT * FROM sales_transactions_dirty;

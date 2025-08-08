## Data Cleaning with SQL Server
Proyek ini berfokus pada proses pembersihan data penjualan menggunakan SQL Server Management Studio (SSMS). Dataset yang digunakan terdiri dari 100 baris data mentah dengan berbagai permasalahan seperti format yang tidak konsisten, nilai yang tidak valid, dan adanya duplikasi data.

## Langkah-langkah pembersihan data meliputi:
1. Mengubah tipe data kolom quantity dan price agar sesuai kebutuhan analisis.
2. Menormalkan teks pada kolom customer_name dan city menjadi huruf kecil serta menghapus spasi berlebih.
3. Membersihkan nilai tidak valid pada kolom quantity dengan mengganti nilai negatif menjadi NULL.
4. Membersihkan kolom diskon dengan menghapus tanda persen dan mengubahnya ke format desimal.
5. Menghapus data duplikat menggunakan metode deteksi berbasis kombinasi kolom tertentu.
6. Mengisi nilai kosong pada kolom email dengan nilai default “unknown”.

Hasil akhir dari proses ini adalah dataset yang sudah bersih, seragam, dan siap digunakan untuk analisis data lebih lanjut.

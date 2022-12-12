# MedStem
## Tugas Kelompok PBP Gasal 2022/2023

[![Build status](https://build.appcenter.ms/v0.1/apps/eae9416d-3ca4-4ad0-9d56-639fad4d333f/branches/main/badge)](https://appcenter.ms)
<br>
Badge broken: https://build.appcenter.ms/v0.1/apps/eae9416d-3ca4-4ad0-9d56-639fad4d333f/branches/main/badge

# How to Run (For Development)

1. Clone the app
```
git clone https://github.com/Nicholas-Sidharta12365/medstem-apk
```

2. Run the app
```
flutter run
```

# How to use
Download the latest release of the app (On-Progress)<br>
Download Link: https://install.appcenter.ms/orgs/f06-pbp-2022-2023/apps/medstem/distribution_groups/public

# Nama-nama anggota kelompok
1. Naila Azizah - 2106705814
2. Amelia Putri Chaerani - 2106751985
3. Teuku Gevin Taufan - 2106750194
4. Rafif Naufal Rahmadika - 2106636275
5. Nicholas Sidharta - 2106752294

# Cerita aplikasi yang diajukan serta manfaatnya
Aplikasi yang akan kami buat adalah sebuah aplikasi untuk memudahkan pelayanan rumah sakit. Aplikasi ini digunakan oleh tenaga medis dan kesehatan dalam rumah sakit guna memudahkan tenaga medis untuk menyusun jadwal pasien, mengalokasikan ruangan yang digunakan untuk pasien, tracking aktivitas lab, tracking request obat, dan menghitung pendapatan harian dari sebuah rumah sakit. Selain itu, dengan menggunakan aplikasi yang dibuat oleh kami dapat mempermudah komunikasi akses antar komponen rumah sakit sehingga tidak terjadi bentrok satu dengan yang lainnya.

# Daftar modul yang akan diimplementasikan
Dari manfaat yang disebutkan diatas, maka kelompok kami membuat lima fitur dalam menunjang aplikasi ini, sebagai berikut:
1. Implementasi login dan logout
Fitur ini mengelompokkan halaman sesuai dengan peran user yang login karena setiap peran akan mendapatkani fitur yang berbeda
2. Childcare (Nicholas Sidharta): mengatur antrian dokter anak
Fitur ini akan dapat diakses oleh tenaga medis khusus anak dan meliputi views sebagai berikut:
    - add queue: untuk menambahkan seorang pasien ke dalam antrian
    - no login page: page untuk pengguna yang tidak login
3. Rawat Jalan (Amelia Putri Chaerani) : mengatur antrian dokter umum
Fitur ini akan dapat diakses oleh tenaga medis dokter umum dan perawat dan meliputi views sebagai berikut:
    - add_queue: untuk menambahkan seorang pasien ke dalam antrian
    - show_queue: untuk menunjukkan antrian pasien yang ada
    - patient_status: untuk menunjukkan status dari pasien, seperti masih menunggu, mengeluarkan diri dari antrian, sedang dalam pemeriksaan, sedang menunggu obat, atau sudah selesai berobat.
    - patient_payment_status: untuk menunjukkan apakah pasien sudah membayar biaya berobat atau belum
4. Vaksin (Rafif Naufal Rahmadika) : track aktivitas vaksin
    - get_vaksin_data: mendapatkan data mengenai jenis-jenis vaksin
    - edit_dose: mengubah dosis vaksin yang diberikan
    - get_added_vaksin: mendapatkan data vaksin yang hanya ditambahkan oleh user
    - add_vaksin: menambah jenis vaksin yang akan digunakan pada pasien
5. Apotek (Naila Azizah): track request obat
    - get_patient_data: untuk mendapatkan data dari apoteker
    - add_prescription: fitur membuat daftar obat preskripsi tiap pasien yang disertai dengan data
        - patient_name
        - patient_age
        - patient_gender
        - medicine
6. Kasir (Teuku Gevin Taufan): track transaksi yang dilakukan perhari
    - create_bill : untuk memasukkan anggaran yang harus dibayar oleh pasien yang hanya ditambahkan oleh penjaga kasir
    - payment_bill : untuk memudahkan pembayaran obat-obat atau perawatan pasien berdasarkan bill yang ada melalui kasir
    - update_bill : untuk mengupdate bill baru jika sudah di tambahkan
    - delete_bill : untuk mengahapus bill yang salah di input dan hanya penjaga kasir yang bisa menghapusnya
    - patient_status_payment: status patient sudah membayar atau belum dari beli obat-obatan atau perawatan (warna merah belum, warna hijau sudah) di bill

# Role atau peran pengguna beserta deskripsinya (karena bisa saja lebih dari satu jenis pengguna yang mengakses aplikasi)
Pengguna yang dituju dalam aplikasi ini adalah healthcare staff dalam rumah sakit. Dalam sebuah rumah sakit terdapat dokter, perawat, apoteker, ahli teknologi lab, radiografer, kasir. Masing - masing memiliki tanggung jawab sesuai dengan pekerjaannya. Peran pengguna dan deskripsinya:
1. Dokter → mengatur antrian dengan pasien, bisa chat dengan tenaga medis lain, mengatur dosis vaksin, menambahkan vaksin, dan mendapatkan data tentang vaksin
2. Perawat → membuat shift kerja sesuai dengan dokter pendamping, chat dengan tenaga medis lain (umumnya apoteker)
3. Apoteker →tracking request obat, tracking obat yang habis dan akan dibeli lagi, tracking obat yang keluar dan masuk, tracking stock vaksin, dan mendapatkan data tentang vaksin.
4. Ahli Farmasi → meracik obat yang berjenis racikan berdasarkan request
5. Ahli teknologi lab → tracking aktivitas lab (alat - alat yang digunakan di lab), tracking hasil lab
6. Radiografer →tracking aktivitas lab (alat - alat yang digunakan di lab), tracking hasil lab
7. Kasir → tracking pemasukan harian yang didapatkan di rumah sakit dari konsultasi dokter, pembelian obat di apotek, atau melakukan test lab.

# Alur pengintegrasian dengan web service untuk terhubung dengan aplikasi web
1. Anggota kelompok mengimplementasikan library http dan map pada proyek Flutter untuk mengambil data dalam format JSON melalui HTTP Request 
2. Menggunakan REST API yang digunakan pada Django. Agar API dapat diakses, maka kami menambahkan middleware dan views.py dengan menggunakan JSONResponse/JSON Serializer.
3. Mengimplementasikan desain yang sudah ditampilkan di web
4. Membuat fungsi asynchronous untuk setiap proses yang memerlukan delivery data atau modifikasi data (integrasi antara front - end dan back - end)
5. Menggunakan metode POST dan GET yang mempunyai fungsi masing - masing, GET untuk Get data JSON dari HTTP Get (mengambil data yang diolah nanti di widget masing - masing), dan POST digunakan untuk mengirim data ke database django.

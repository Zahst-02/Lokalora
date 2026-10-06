# LOKALORA

## Description
Lokalora adalah marketplace digital khusus untuk produk lokal dan UMKM Indonesia. Aplikasi ini memungkinkan pengguna untuk menjelajahi, mencari, dan membeli berbagai macam produk lokal dari berbagai kategori seperti Makanan, Minuman, Fashion, Kerajinan, dan lain-lain. Dengan tagline "Temukan Produk Lokal, Dukung UMKM", Lokalora dirancang dengan antarmuka yang bersih, modern, dan tidak menjiplak platform lain.

## Features
- **Katalog Produk:** Menampilkan daftar produk lokal dalam grid yang rapi.
- **Pencarian Real-time:** Fitur pencarian untuk menemukan produk atau toko dengan cepat.
- **Detail Produk:** Informasi detail produk, pemilihan varian, pengatur kuantitas, dan tambah ke keranjang.
- **Keranjang Belanja (CRUD):** Tambah produk, ubah jumlah, dan hapus produk dari keranjang dengan perhitungan subtotal otomatis.
- **Checkout & Pengiriman:** Halaman checkout yang menampilkan rincian pesanan dan pilihan pengiriman (Reguler/Express).
- **Payment Sandbox:** Simulasi pembayaran menggunakan Virtual Account dengan hitung mundur dan konfirmasi pembayaran.
- **Riwayat Pesanan:** Melacak status pesanan setelah pembayaran berhasil.

## Screens
1. **Splash Screen:** Layar pembuka aplikasi.
2. **Home:** Beranda dengan banner, kategori, dan produk populer.
3. **Search:** Halaman pencarian produk.
4. **Product List:** Daftar produk (Explore).
5. **Product Detail:** Informasi lengkap tentang produk.
6. **Cart:** Keranjang belanja.
7. **Checkout:** Halaman konfirmasi pesanan dan pengiriman.
8. **Payment:** Simulasi pembayaran Virtual Account.
9. **Payment Success:** Layar konfirmasi pembayaran sukses.
10. **Order Detail:** Detail pesanan yang telah dibayar.
11. **Orders:** Daftar riwayat pesanan.
12. **Profile:** Halaman profil pengguna.

## Technology
- **Bahasa Pemrograman:** Kotlin
- **IDE:** Android Studio
- **Arsitektur:** MVVM (Model-View-ViewModel)
- **UI Toolkit:** XML Layouts & Material Components
- **Asynchronous Programming:** Kotlin Coroutines
- **Navigation:** Jetpack Navigation Component
- **Image Loading:** Glide
- **Network / API:** Fake Repository (Mock Backend) & Retrofit (optional for live backend)

## Architecture
Aplikasi ini menggunakan arsitektur MVVM (Model-View-ViewModel) yang memisahkan logika antarmuka pengguna (View) dari logika bisnis dan pengelolaan data (ViewModel & Repository).
- **UI Layer:** Activity, Fragment, dan XML.
- **Presentation Layer:** ViewModel yang mengelola state menggunakan `LiveData` atau `StateFlow`.
- **Data Layer:** `AppRepository` yang bertindak sebagai sumber data utama. Saat ini menggunakan implementasi in-memory (Fake Repository) untuk mendemonstrasikan fungsionalitas tanpa memerlukan koneksi backend aktif.

## Backend & Database
Berdasarkan permintaan pengguna, aplikasi ini telah disesuaikan untuk menggunakan **Mock Data / In-Memory Database** agar aplikasi dapat berjalan sepenuhnya secara mandiri (offline) tanpa perlu setup backend Supabase. Semua fitur CRUD (Create, Read, Update, Delete) pada keranjang belanja berfungsi dengan sempurna di dalam memori selama aplikasi berjalan.

## Installation
1. Clone repositori ini atau download source code.
2. Buka project di **Android Studio**.
3. Tunggu hingga proses sinkronisasi Gradle selesai.
4. Jalankan aplikasi pada emulator atau perangkat fisik (API 24+).

## Run Project & Build APK
1. Untuk menjalankan aplikasi: Klik tombol **Run** (Shift + F10) di Android Studio.
2. Untuk membuild APK Debug: Pergi ke menu `Build` -> `Build Bundle(s) / APK(s)` -> `Build APK(s)`.
3. Anda juga dapat membuild melalui terminal dengan perintah:
   ```bash
   ./gradlew assembleDebug
   ```
4. APK akan berada di dalam direktori `app/build/outputs/apk/debug/`.

## Testing
Aplikasi dapat diuji dengan skenario berikut:
1. Buka aplikasi hingga masuk ke Beranda.
2. Gunakan fitur Pencarian untuk mencari "Kopi".
3. Pilih salah satu produk, atur kuantitas, dan tekan "Tambah ke Keranjang".
4. Buka Keranjang, ubah kuantitas menggunakan tombol `+` atau `-`, lalu coba hapus produk lain menggunakan ikon tempat sampah (CRUD test).
5. Lanjutkan ke Checkout, pilih metode pengiriman, dan perhatikan perubahan total.
6. Buat Pesanan, lalu simulasikan pembayaran pada halaman Virtual Account.
7. Tekan "Cek Status Pembayaran" untuk melihat halaman sukses dan Detail Pesanan.

## Author
Dikembangkan untuk Ujian Akhir Semester (UAS) Pemrograman Mobile Dasar.

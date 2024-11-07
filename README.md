# WeatherApp

WeatherApp adalah aplikasi cuaca yang menyediakan informasi terbaru tentang kondisi cuaca di berbagai lokasi. Aplikasi ini dibuat menggunakan Xcode dengan arsitektur VIPER untuk mengelola alur data dan logika tampilan.

## Fitur

- **Informasi Cuaca Saat Ini**: Menampilkan suhu, kelembapan, arah angin, dan kondisi umum cuaca.
- **Perkiraan Cuaca**: Menampilkan data cuaca per jam dan harian, memungkinkan pengguna mempersiapkan diri untuk cuaca di masa depan.
- **Tampilan Grafik dan Visual**: Grafik perubahan suhu dan kelembapan serta visual yang menarik untuk mendukung data.
- **Pencarian Lokasi**: Pengguna dapat mencari cuaca untuk berbagai kota atau lokasi.

## Prasyarat

Sebelum mengunduh aplikasi, pastikan Anda memiliki:
- **Xcode** versi terbaru
- **CocoaPods** untuk mengelola dependensi (opsional, jika Anda menggunakan pustaka eksternal)

## Instalasi

1. Clone repositori ke perangkat Anda:
    ```bash
    git clone https://github.com/username/WeatherApp.git
    ```

2. Buka project di Xcode:
    ```bash
    cd WeatherApp
    open WeatherApp.xcodeproj
    ```

3. (Opsional) Instal dependensi menggunakan CocoaPods:
    ```bash
    pod install
    ```
   Setelah instalasi selesai, buka `.xcworkspace` untuk menjalankan project dengan pustaka yang terpasang.

4. Jalankan aplikasi di simulator atau perangkat iOS dengan menekan `Cmd + R`.

## Struktur Proyek

Aplikasi ini dibangun dengan arsitektur VIPER:
- **View**: Bertanggung jawab untuk menampilkan data di UI.
- **Interactor**: Mengelola logika bisnis dan data.
- **Presenter**: Menghubungkan logika bisnis dengan tampilan.
- **Entity**: Model data aplikasi.
- **Router**: Mengelola alur navigasi antar layar.

## Kontribusi

Jika Anda ingin berkontribusi pada project ini:
1. Fork repositori.
2. Buat branch baru untuk fitur atau perbaikan:
   ```bash
   git checkout -b feature-nama-fitur


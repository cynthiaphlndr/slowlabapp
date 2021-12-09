[![Release](https://github.com/ariqsyahalam/slowlabapp/actions/workflows/release.yml/badge.svg)](https://github.com/ariqsyahalam/slowlabapp/actions/workflows/release.yml)

# SlowLab App [Kelompok C09]

Website ini merupakan perwujudan dari studi kasus dan riset internal kelompok kami terhadap beberapa fasilitas laboratorium pengecekan covid-19 di Indonesia. Pada riset yang kami lakukan, kami menemukan bahwa banyak dari laboratorium penyedia tes covid-19 masih bergerak semi-online dimana pemesanan atau booking dilakukan melalui aplikasi pesan “Whatsapp” atau bahkan hanya dapat dilakukan secara offline yaitu datang langsung ke lab sehingga dianggap kurang efisien dalam menangani pengecekan covid-19 di Indonesia yang perlu didukung oleh pembatasan mobilitas dari masyarakat. Studi kasus internal dilakukan pada Fast Lab, salah satu pionir laboratorium tes covid-19 yang cabangnya sudah tersebar di berbagai kota di Indonesia, tetapi tidak memiliki website resmi dalam pelaksanaan operasinya. Pada studi kasus ini ditemukan bahwa:

1.  Informasi mengenai cabang laboratorium sulit didapat, karena tidak adanya situs resmi informasi mengenai cabang tersebar tidak beraturan di Google sehingga menyulitkan masyarakat untuk mengetahui cabang terdekat dari Fast Lab.
2.  Pemesanan booking online harus melalui pihak ketiga, karena tidak ada situs resmi masyarakat harus mendaftarkan diri pada situs pihak ketiga untuk dapat melakukan pemesanan jasa secara online.
3.  Pengambilan hasil tes harus datang ke tempat, karena tidak ada situs resmi masyarakat harus kembali datang beberapa hari setelah tes ke laboratorium untuk dapat mendapat akses terhadap hasil tes yang telah dilakukan sebelumnya.
4.  Informasi mengenai produk tes sulit didapat, karena tidak adanya situs resmi masyarakat harus secara mandiri melakukan riset terhadap jenis produk yang disediakan oleh Fast Lab.
5.  Customer service terbatas, karena tidak adanya situs resmi berisi kumpulan pertanyaan ataupun kotak pertanyaan masyarakat kesulitan untuk mendapat informasi lebih dikarenakan customer service terbatas.

Dari temuan-temuan yang kami dapati, kami mencoba untuk memberikan solusi melalui pembuatan situs “Slow Lab” berupa situs yang nantinya dapat digunakan bagi laboratorium covid-19 dalam pelaksanaan operasinya secara daring. Manfaat dari adanya situs ini adalah untuk dapat membantu masyarakat mendapatkan akses lebih baik terhadap tes covid-19 serta membantu laboratorium covid-19 untuk dapat beroperasi secara lebih efisien sehingga nantinya dapat bersama-sama menyukseskan Indonesia tanpa covid-19 melalui deteksi dini yang cepat, mudah, dan tanggap.

## Anggota

| Nama                          | NPM        |
| ----------------------------- | ---------- |
| Jasmine Ainal Muthia          | 2006596806 |
| Reyhan Ariq Syahalam          | 2006524100 |
| Muhammad Hilmy Noerfatih      | 2006597512 |
| Adhin Abdallah Muhammad Sidik | 2006597310 |
| Muhammad Satrio Haryo Kusumo  | 2006597771 |
| Cynthia Philander             | 2006597292 |
| Ghaitsa Maulidina Shofa       | 2006597014 |

## Link download aplikasi

[Release App](https://github.com/ariqsyahalam/slowlabapp/releases)

## Daftar modul yang akan diimplementasikan

- Home (Muhammad Satrio)
- Lokasi (Cynthia Philander)
- Authentication (Muhammad Hilmy)
- Booking (Reyhan Ariq)
- Forum (Ghaitsa Maulidina)
- Cek Hasil Tes (Jasmine Ainal)
- Reservasi Tes (Adhin Abdallah)

## Langkah Integrasi ke Web Service
1. Mengimplementasikan flutter support authentication dengan library Dart
2. Mengimplementasikan JsonResponse atau JSON Serializer Django pada backend Django.
3. Mengimplementasikan widget flutter sesuai dengan desain website yang di konversikan kedalam tampilan mobile.
4. Mengintegrasikan frontend-backend website dan flutter dengan menggunakan konsep asynchronous HTTP.

## Persona

### Masyarakat umum (belum login ke SlowLab)

- Membaca forum
- Mencari lokasi tes covid yang tersedia
- Melakukan pengecekan hasil tes

### Masyarakat umum (sudah login ke SlowLab)

- Membaca dan mengisi forum
- Mencari lokasi tes covid yang tersedia
- Melakukan pengecekan hasil tes
- Reservasi tes COVID-19

### Admin (Staff SlowLab)

- Membaca dan menjawab forum
- Menambahkan lokasi tes covid
- Melihat daftar reservasi tes COVID-19

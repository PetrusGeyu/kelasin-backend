# 📚 Zerona Backend

Backend API untuk aplikasi **Zerona** — sebuah platform pembelajaran daring (e-learning) yang mengelola pengguna, kursus, pelajaran, umpan balik, serta pendaftaran siswa pada kursus.

---

## 🧩 Teknologi yang Digunakan

- **Ruby** 3.3.0
- **Ruby on Rails** 8.0.3
- **MySQL** (melalui `mysql2` adapter)
- **Puma** sebagai server aplikasi
- **JSON API** (tanpa tampilan HTML)
- **Supabase / Railway** untuk deployment dan database hosting

---

## ⚙️ Fitur Utama

- 🔐 Registrasi & Login pengguna (`/register`, `/login`)
- 👤 Melihat profil pengguna (`/me`)
- 🎓 CRUD Kursus (`/courses`)
- 📚 Manajemen pelajaran per kursus (`/courses/:id/lessons`)
- 💬 Feedback dan ulasan kursus (`/courses/:id/feedbacks`)
- 📝 Enroll dan unenroll kursus (`/courses/:id/enroll`)
- 🎯 Melihat daftar kursus yang diikuti (`/mycourses`)
- 🚀 Endpoint root untuk memastikan server aktif (`GET /`)

---

## 🗂️ Struktur API (Routes)

| Metode              | Endpoint                 | Deskripsi                    |
| ------------------- | ------------------------ | ---------------------------- |
| POST                | `/register`              | Daftar akun baru             |
| POST                | `/login`                 | Login pengguna               |
| GET                 | `/me`                    | Tampilkan profil pengguna    |
| GET                 | `/mycourses`             | Kursus yang diikuti pengguna |
| GET                 | `/courses`               | Daftar semua kursus          |
| POST                | `/courses`               | Tambah kursus baru           |
| PUT/PATCH           | `/courses/:id`           | Ubah data kursus             |
| DELETE              | `/courses/:id`           | Hapus kursus                 |
| POST                | `/courses/:id/enroll`    | Daftar ke kursus             |
| DELETE              | `/courses/:id/enroll`    | Batalkan pendaftaran kursus  |
| GET/POST/PUT/DELETE | `/courses/:id/lessons`   | CRUD pelajaran dalam kursus  |
| GET/POST/PUT/DELETE | `/courses/:id/feedbacks` | CRUD feedback kursus         |
| GET                 | `/enrollments`           | Daftar semua enrollments     |
| CRUD                | `/progresses`            | Kemajuan belajar siswa       |

---

## 🧰 Instalasi & Konfigurasi Lokal

1. **Clone repository**

   ```bash
   git clone https://github.com/PetrusGeyu/zerona-backend.git
   cd zerona-backend
   ```

2. **Install dependencies**

   ```bash
   bundle install
   ```

3. **Buat file `.env`**

   ```env
   DATABASE_URL=mysql2://user:password@host:port/db_name
   SECRET_KEY_BASE=<hasil dari rails secret>
   RAILS_ENV=development
   ```

4. **Setup database**

   ```bash
   rails db:create
   rails db:migrate
   ```

5. **Jalankan server**

   ```bash
   rails server -p 3000
   ```

6. **Tes API**
   Buka [http://localhost:3000](http://localhost:3000)  
   atau kirim request dengan Postman.

---

## 🚀 Deploy ke Railway

### 1️⃣ Persiapan

Pastikan variabel berikut sudah diset di Railway:

| Nama              | Deskripsi                 |
| ----------------- | ------------------------- |
| `DATABASE_URL`    | URL koneksi MySQL         |
| `SECRET_KEY_BASE` | Hasil dari `rails secret` |
| `PORT`            | Set ke `8080`             |
| `RAILS_ENV`       | `production`              |

### 2️⃣ Konfigurasi penting

- Pastikan di `puma.rb` ada baris:
  ```ruby
  port ENV.fetch("PORT") { 8080 }
  ```
- Di `config/environments/production.rb`, nonaktifkan ActionCable & SolidQueue:
  ```ruby
  config.cache_store = :memory_store
  config.active_job.queue_adapter = :async
  config.action_cable.mount_path = nil
  config.action_cable.url = nil
  ```

### 3️⃣ Deploy

Push ke GitHub, lalu Railway akan otomatis build & deploy.  
Jika berhasil, log akan menampilkan:

```
Listening on http://0.0.0.0:8080
```

---

## 🧱 Struktur Folder

```
app/
 ├── controllers/
 ├── models/
 ├── views/ (kosong, karena API-only)
 ├── jobs/
 ├── mailers/
config/
 ├── database.yml
 ├── environments/
 ├── routes.rb
```

---

## ✅ Catatan Tambahan

- **Action Cable**, **Solid Queue**, dan **Solid Cache** dinonaktifkan di production untuk mencegah error koneksi database (`cache` / `cable`).
- Gunakan endpoint `/` untuk health check Railway.
- Semua response dalam format **JSON**.

---

## 👨‍💻 Kontributor

**Petrus Hendrick Geyu**  
📧 [GitHub Profile](https://github.com/PetrusGeyu)

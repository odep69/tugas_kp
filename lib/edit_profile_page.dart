import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final Color darkBlueColor = const Color(0xFF0D325E);
  final Color lightBlueColor = const Color(0xFF42A5F5);
  
  // HAPUS: Controller _nameController dan _emailController tidak diperlukan lagi
  // HAPUS: Logika dispose untuk controller juga dihapus

  // Dummy List Kendaraan (Kosong sesuai permintaan)
  List<Map<String, String>> registeredVehicles = []; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        elevation: 0,
        centerTitle: true,
        title: const Text('Profile', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. FOTO PROFIL
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFE3F2FD), 
              child: Icon(Icons.person, size: 60, color: Color(0xFF90CAF9)),
            ),
            const SizedBox(height: 10),

            // 2. NAMA (Teks Statis)
            const Text(
              'Nama user',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            
            // 3. EMAIL (Teks Statis)
            const Text(
              'email user',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 30), // Jarak ke Tombol Simpan

            // 4. TOMBOL SIMPAN (Berfungsi sebagai tombol utama di halaman ini)
            SizedBox(
              width: double.infinity,
              child: _buildSaveButton('Simpan', () {
                // Aksi Simpan (Sekarang hanya menampilkan SnackBar)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Simpan ditekan (Tidak ada perubahan yang disimpan karena data statis).'))
                );
              }),
            ),
            const SizedBox(height: 40), 

            // 5. KENDARAAN TERDAFTAR HEADER
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Kendaraan Terdaftar',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15), 

            // 6. DAFTAR KENDARAAN (KOSONG sesuai permintaan)
            registeredVehicles.isEmpty
                ? const Text(
                    'Belum ada kendaraan terdaftar.',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  )
                : Column(
                    children: registeredVehicles.map((vehicle) {
                      return _buildVehicleCard(context, vehicle['license']!, vehicle['model']!);
                    }).toList(),
                  ),
            const SizedBox(height: 30), 
            
            // 7. TOMBOL TAMBAH KENDARAAN
            SizedBox(
              width: double.infinity,
              child: _buildAddVehicleButton('Tambah Kendaraan', () {
                // Aksi Tambah Kendaraan
              }),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // HAPUS: Widget Helper _buildInputField telah dihapus

  // Widget Helper: Tombol Simpan (Biru)
  Widget _buildSaveButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: lightBlueColor, // Warna Biru
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
      ),
      child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  // Widget Helper: Tombol Tambah Kendaraan (Outline Putih)
  Widget _buildAddVehicleButton(String text, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white),
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  // Widget Helper: Card Kendaraan
  Widget _buildVehicleCard(BuildContext context, String license, String model) {
     return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(license, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
              Text(model, style: const TextStyle(fontSize: 16, color: Colors.black54)),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Text('Edit', style: TextStyle(color: lightBlueColor, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 15),
              GestureDetector(
                onTap: () {},
                child: const Text('Hapus', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
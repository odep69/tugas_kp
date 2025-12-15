import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Color darkBlueColor = const Color(0xFF0D325E);
  final Color lightBlueColor = const Color(0xFF42A5F5);

  // Status Switch Notifikasi
  bool isPushNotificationOn = true;
  bool isEmailNotificationOn = true;
  bool isSecondEmailNotificationOn = false; // Asumsi ini adalah notifikasi email kedua

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        elevation: 0,
        centerTitle: true,
        title: const Text('Pengaturan', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. TOMBOL UBAH PASSWORD
            SizedBox(
              width: double.infinity,
              child: _buildPrimaryButton('Ubah Password', () {
                // Aksi Ubah Password (Navigasi ke halaman Ubah Password)
              }),
            ),
            const SizedBox(height: 30),

            // 2. 2FA (Opsional) - Judul
            const Text(
              '2FA (Opsional)',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Card Pengaturan Notifikasi
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  // Push Notifikasi
                  _buildSwitchRow(
                    'Push notifikasi', 
                    isPushNotificationOn, 
                    (bool value) {
                      setState(() {
                        isPushNotificationOn = value;
                      });
                    }
                  ),
                  const Divider(height: 0, color: Colors.grey),
                  
                  // Email Notifikasi 1
                   _buildSwitchRow(
                    'Email notifikasi', 
                    isEmailNotificationOn, 
                    (bool value) {
                      setState(() {
                        isEmailNotificationOn = value;
                      });
                    }
                  ),
                  const Divider(height: 0, color: Colors.grey),
                  
                  // Email Notifikasi 2 (Sesuai contoh gambar)
                  _buildSwitchRow(
                    'Email notifikasi', 
                    isSecondEmailNotificationOn, 
                    (bool value) {
                      setState(() {
                        isSecondEmailNotificationOn = value;
                      });
                    }
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // 3. LAINNYA - Judul
            const Text(
              'Lainnya',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Card Pengaturan Lainnya
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _buildGeneralOption('Bahasa', 'Sistem', () {
                    // Aksi Ubah Bahasa
                  }),
                  const Divider(height: 0, color: Colors.grey),
                  _buildGeneralOption('Tema', 'Terang', () {
                    // Aksi Ubah Tema
                  }),
                  const Divider(height: 0, color: Colors.grey),
                  _buildGeneralOption('Tentang Aplikasi', 'Versi 1.0', () {
                    // Aksi Tentang Aplikasi
                  }),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget Helper: Tombol Primary (Ubah Password)
  Widget _buildPrimaryButton(String text, VoidCallback onPressed) {
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

  // Widget Helper: Baris dengan Switch (Notifikasi)
  Widget _buildSwitchRow(String title, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.black87, fontSize: 16)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: lightBlueColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }

  // Widget Helper: Baris Opsi Umum (Bahasa, Tema)
  Widget _buildGeneralOption(String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(color: Colors.black87, fontSize: 16)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 16)),
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
        ],
      ),
      onTap: onTap,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:projec_kp/login.dart';
import 'package:projec_kp/edit_profile_page.dart';
import 'package:projec_kp/settings_page.dart';
import 'package:projec_kp/help_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  final Color darkBlueColor = const Color(0xFF0D325E);
  final Color lightBlueColor = const Color(0xFF42A5F5);

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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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

            // Nama dan Email
            const Text(
              'Nama user',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'email user',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 20),

            // 2. TOMBOL EDIT PROFILE (Sudah Panjang)
            SizedBox(
              width: double.infinity,
              child: _buildPrimaryButton('Edit Profile', () {
                // Aksi Edit Profile DIUBAH MENJADI NAVIGASI
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfilePage()),
                );
              }, darkBlueColor), // Mengirim darkBlueColor untuk teks
            ),
            const SizedBox(height: 15),

            // 3. PENGATURAN LAINNYA (Dibuat Panjang dengan Jarak Konsisten)
            
            // Ubah Password
            SizedBox(
              width: double.infinity,
              child: _buildPrimaryButton('Ubah Password', () {
                // Aksi Ubah Password
              }, darkBlueColor),
            ),
            const SizedBox(height: 15),
            
            // Pengaturan Notifikasi
            SizedBox(
              width: double.infinity,
              child: _buildPrimaryButton('Pengaturan Notifikasi', () {
                // Aksi Pengaturan Notifikasi DIUBAH MENJADI NAVIGASI
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              }, darkBlueColor),
            ),
            const SizedBox(height: 15),
            
            // Bantuan/Hubungi CS
            SizedBox(
              width: double.infinity,
              child: _buildPrimaryButton('Bantuan/Hubungi CS', () {
                // Aksi Bantuan/CS DIUBAH MENJADI NAVIGASI
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpPage()),
                );
              }, darkBlueColor),
            ),
            const SizedBox(height: 40),

            // 4. TOMBOL LOGOUT (Sudah Panjang)
            SizedBox(
              width: double.infinity,
              child: _buildPrimaryButton('LogOut', () {
                // <<< LOGIKA LOGOUT DI SINI >>>
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false, // Menghapus semua rute sebelumnya
                );
              }, darkBlueColor),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget Helper untuk Tombol Solid Putih (Primary Button Style)
  Widget _buildPrimaryButton(String text, VoidCallback onPressed, Color textColor) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Background Putih
        foregroundColor: textColor, // Teks Biru Gelap (darkBlueColor)
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0, 
      ),
      child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
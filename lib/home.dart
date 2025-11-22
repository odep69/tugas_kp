// lib/home_page.dart
import 'package:flutter/material.dart';
import 'package:projec_kp/login.dart';
import 'package:projec_kp/loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color darkBlueColor = const Color(0xFF0D325E);
  // Indeks untuk BottomNavigationBar
  int _selectedIndex = 0; 

  // Daftar widget untuk setiap tab (hanya menampilkan Home untuk saat ini)
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeContent(), // Konten Home utama
    const Center(child: Text('Booking Page', style: TextStyle(color: Colors.white))),
    const Center(child: Text('Inventory Page', style: TextStyle(color: Colors.white))),
    const ProfileContent(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        elevation: 0,
        title: const Text(
          'MYBengkel',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          // Ikon notifikasi (lonceng)
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(Icons.notifications_none, color: Colors.white, size: 30),
          ),
        ],
      ),
      
      // Tampilkan konten yang dipilih berdasarkan tab
      body: _widgetOptions.elementAt(_selectedIndex),

      // --- Bottom Navigation Bar ---
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Booking'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2), label: 'Inventory'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF42A5F5), // Warna biru cerah
        unselectedItemColor: Colors.white70,
        onTap: _onItemTapped,
        backgroundColor: darkBlueColor,
        type: BottomNavigationBarType.fixed, // Penting agar warna latar belakang tetap
      ),
    );
  }
}


// --- Widget Konten Home Utama ---
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  final Color darkBlueColor = const Color(0xFF0D325E);

  // Widget pembantu untuk tombol aksi cepat
  Widget _buildActionButton(String title, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? darkBlueColor.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isActive ? Colors.white : Colors.transparent),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.white70,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  // Widget pembantu untuk Kartu Inventory
  Widget _buildInventoryCard(String title, String status, Color statusColor) {
    return Expanded(
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          height: 120, // Ketinggian tetap untuk inventory card
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: darkBlueColor,
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: 16,
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),

          // --- Tombol Book Service ---
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                // Logika Book Service
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF42A5F5), // Biru cerah
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 5,
              ),
              child: const Text(
                'Book Service',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // --- Kartu Service Ruitin ---
          Card(
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '#XX-8211',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Service Rutin',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Hari ini, 10:30',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          'Disetujui',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          // --- Quick Actions Header dan Tombol ---
          const Text(
            'Quick Actions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildActionButton('Active', true),
              const SizedBox(width: 10),
              _buildActionButton('History', false),
              const SizedBox(width: 10),
              _buildActionButton('Schedule', false),
            ],
          ),

          const SizedBox(height: 30),

          // --- Inventory Header ---
          const Text(
            'Inventory',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          // --- Inventory Cards ---
          Row(
            children: [
              // Kartu Tire
              _buildInventoryCard(
                'Tire',
                '12 in stock',
                Colors.black54, // Warna abu-abu untuk stock
              ),
              const SizedBox(width: 15),
              // Kartu Oil
              _buildInventoryCard(
                'Oil',
                'Out of stock',
                Colors.red, // Warna merah untuk out of stock
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  final Color darkBlueColor = const Color(0xFF0D325E);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Welcome to Profile Page',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 30),
          // --- Tombol Logout ---
          SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {
                // Logika Logout: Navigasi ke LoadingScreen dengan tujuan LoginPage.
                // Menggunakan pushAndRemoveUntil untuk menghapus semua history (Halaman Home, dll.)
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoadingScreen(
                            nextPage: LoginPage(), // Tujuan: Halaman Login
                          )),
                  (Route<dynamic> route) => false,
                );
              },
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text(
                'Logout',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: darkBlueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
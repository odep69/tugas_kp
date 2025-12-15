// lib/home_page.dart
import 'package:flutter/material.dart';
import 'package:projec_kp/login.dart';
import 'package:projec_kp/loading.dart';
import 'package:projec_kp/booking.dart';
import 'package:projec_kp/inventory_page.dart';
import 'package:projec_kp/history.dart';
import 'package:projec_kp/profile_page.dart';

class HomePage extends StatefulWidget {
  // Tambahkan variabel opsional untuk menerima data booking baru
  final String? bookedServiceName;
  final String? bookedDate;
  final String? bookedTime;

  const HomePage({
    super.key,
    this.bookedServiceName,
    this.bookedDate,
    this.bookedTime,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color darkBlueColor = const Color(0xFF0D325E);
  int _selectedIndex = 0;

  // Kita hapus list statis _widgetOptions dan ganti dengan method
  // agar bisa mengakses data dari widget (widget.bookedServiceName)
  List<Widget> _getWidgetOptions() {
    return <Widget>[
      // Tab 0: HomeContent (Kita kirim data ke sini)
      HomeContent(
        serviceName: widget.bookedServiceName,
        dateStr: widget.bookedDate,
        timeStr: widget.bookedTime,
      ),
      // Tab 1-3: Placeholder
      const Center(child: Text('Booking History', style: TextStyle(color: Colors.white))),
      const Center(child: Text('Inventory Page', style: TextStyle(color: Colors.white))),
      const ProfileContent(),
    ];
  }

void _onItemTapped(int index) {
  if (index == 2) { 
    // Index 2: Inventory
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InventoryListPage()),
    );
  } else if (index == 1) { 
    // Index 1: Booking/History
    final homeWidget = widget; 
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryPage(
          latestServiceName: homeWidget.bookedServiceName, 
          latestDate: homeWidget.bookedDate, 
          latestTime: homeWidget.bookedTime,
        ),
      ),
    );
  } else if (index == 3) { 
    // Index 3: Profile (Tambahkan ini)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  } else {
    // Index 0: Home
    setState(() {
      _selectedIndex = index;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    // Ambil widget berdasarkan index saat ini
    final currentWidget = _getWidgetOptions().elementAt(_selectedIndex);

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
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(Icons.notifications_none, color: Colors.white, size: 30),
          ),
        ],
      ),
      
      body: currentWidget,

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Booking'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2), label: 'Inventory'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF42A5F5),
        unselectedItemColor: Colors.white70,
        onTap: _onItemTapped,
        backgroundColor: darkBlueColor,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

// --- Widget Konten Home Utama ---
class HomeContent extends StatelessWidget {
  // Variabel data booking
  final String? serviceName;
  final String? dateStr;
  final String? timeStr;

  const HomeContent({
    super.key,
    this.serviceName,
    this.dateStr,
    this.timeStr,
  });

  final Color darkBlueColor = const Color(0xFF0D325E);

  @override
  Widget build(BuildContext context) {
    // Cek apakah ada data booking baru?
    bool hasBooking = serviceName != null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),

          // Tombol Book Service
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BookingStep1Page()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF42A5F5),
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

          // --- KARTU STATUS SERVICE (DINAMIS) ---
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
                  
                  // Tampilkan Nama Service (Default: 'No Active Service' jika kosong)
                  Text(
                    hasBooking ? serviceName! : 'No Active Service', 
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Tampilkan Tanggal & Waktu
                      Expanded(
                        child: Text(
                          hasBooking ? '$dateStr, $timeStr' : 'Tap "Book Service" to start',
                          style: const TextStyle(fontSize: 15, color: Colors.black54),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      
                      // Tag Status
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: hasBooking ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          hasBooking ? 'Booked' : 'Inactive',
                          style: TextStyle(
                            color: hasBooking ? Colors.green : Colors.grey,
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

          // --- Quick Actions Header ---
          const Text('Quick Actions', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            children: [
              // Tombol 'Active' (Tidak melakukan apa-apa, karena sudah di halaman ini)
              _buildActionButton(context, 'Active', true, 0), 
              const SizedBox(width: 10),
              // Tombol 'History'
              _buildActionButton(context, 'History', false, 1), 
              const SizedBox(width: 10),
              // Tombol 'Schedule'
              _buildActionButton(context, 'Schedule', false, 2), 
            ],
          ),
          
          const SizedBox(height: 30),

          // --- Inventory Header ---
          const Text('Inventory', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildInventoryCard(context, 'Tire', '12 in stock', Colors.black54),
              const SizedBox(width: 15),
              _buildInventoryCard(context, 'Oil', 'Out of stock', Colors.red),
            ],
          ),
        ],
      ),
    );
  }

    Widget _buildActionButton(BuildContext context, String title, bool isActive, int actionIndex) {
    final Color darkBlueColor = const Color(0xFF0D325E);
  
  // Ambil data dari HomeContent (this.) - Ini akan menjadi null jika belum ada booking.
  final latestName = serviceName; 
  final latestDate = dateStr;
  final latestTime = timeStr;

  final Map<int, Widget> destinationPages = {
    // KITA AKAN SELALU MENGIRIM DATA LATEST BOOKING KE HISTORYPAGE
    1: HistoryPage(
          latestServiceName: latestName, // Sudah benar
          latestDate: latestDate, // Sudah benar
          latestTime: latestTime, // Sudah benar
       ), 
    2: const SchedulePage(), 
  };
    
    return GestureDetector(
      onTap: () {
        if (actionIndex != 0) {
          // Navigasi jika bukan tab 'Active'
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationPages[actionIndex]!),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? darkBlueColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isActive ? Colors.white : Colors.transparent),
        ),
        child: Text(title, style: TextStyle(color: isActive ? Colors.white : Colors.white70, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
      ),
    );
  }

  Widget _buildInventoryCard(BuildContext context, String title, String status, Color statusColor) {
    return Expanded(
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkBlueColor)),
              Text(status, style: TextStyle(fontSize: 16, color: statusColor, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Widget Profile (Untuk Logout) ---
class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
            // Logout logic
             Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false,
                );
        },
        icon: const Icon(Icons.logout, color: Colors.red),
        label: const Text('Logout', style: TextStyle(color: Color(0xFF0D325E))),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
      ),
    );
  }
}
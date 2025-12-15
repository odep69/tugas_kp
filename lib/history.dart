import 'package:flutter/material.dart';
import 'package:projec_kp/home.dart'; // Import HomePage untuk mengakses data

// --- Definisi Model Riwayat ---
class BookingHistoryItem {
  final String id;
  final String serviceName;
  final String dateTime;
  final String status;
  final Color statusColor;

  BookingHistoryItem({
    required this.id,
    required this.serviceName,
    required this.dateTime,
    required this.status,
    required this.statusColor,
  });
}

// =========================================================================
// HISTORY PAGE
// =========================================================================

class HistoryPage extends StatelessWidget {
  final String? latestServiceName;
  final String? latestDate;
  final String? latestTime;

  const HistoryPage({
    super.key,
    this.latestServiceName,
    this.latestDate,
    this.latestTime,
  });

  final Color darkBlueColor = const Color(0xFF0D325E);
  final Color lightBlueColor = const Color(0xFF42A5F5);

  @override
  Widget build(BuildContext context) {
    // Gabungkan logika pembuatan list di sini
    List<BookingHistoryItem> historyList = [];

    if (latestServiceName != null && latestDate != null && latestTime != null) {
      historyList.add(
        BookingHistoryItem(
          id: '#XX-8211',
          serviceName: latestServiceName!,
          dateTime: '$latestDate, $latestTime',
          status: 'Booked',
          statusColor: lightBlueColor,
        ),
      );
    }

    return Scaffold(
      backgroundColor: darkBlueColor,
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        elevation: 0,
        centerTitle: true,
        title: const Text('History', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              children: [
                // Quick Actions (Hanya sebagai tampilan, tidak berfungsi navigasi di sini)
                Row(
                  children: [
                    _buildHistoryAction('Active', false, darkBlueColor, lightBlueColor),
                    const SizedBox(width: 10),
                    _buildHistoryAction('History', true, darkBlueColor, lightBlueColor),
                    const SizedBox(width: 10),
                    _buildHistoryAction('Schedule', false, darkBlueColor, lightBlueColor),
                  ],
                ),
                const SizedBox(height: 20),
                
                // Search Bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // LIST RIWAYAT
          Expanded(
            child: historyList.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.history_toggle_off, color: Colors.white70, size: 50),
                        SizedBox(height: 10),
                        Text(
                          'No booking history yet',
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: historyList.length,
                    itemBuilder: (context, index) {
                      final item = historyList[index];
                      return _buildHistoryCard(item);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // Widget untuk Card Riwayat
  Widget _buildHistoryCard(BookingHistoryItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.id,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 5),
              Text(
                item.serviceName,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 5),
              Text(
                item.dateTime,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
          // Tag Status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: item.statusColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              item.status,
              style: TextStyle(
                color: item.statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Helper untuk Tampilan Quick Action di halaman History
  Widget _buildHistoryAction(String title, bool isSelected, Color primaryColor, Color secondaryColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? secondaryColor : primaryColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? secondaryColor : Colors.transparent),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white70,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

// =========================================================================
// SCHEDULE PAGE (PLACEHOLDER)
// =========================================================================

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});
  
  final Color darkBlueColor = const Color(0xFF0D325E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        elevation: 0,
        centerTitle: true,
        title: const Text('Schedule', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: Text(
          'Halaman Schedule\n(Fitur akan dikembangkan di sini)',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
      ),
    );
  }
}
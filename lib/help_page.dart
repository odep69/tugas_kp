import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  final Color darkBlueColor = const Color(0xFF0D325E);
  final Color lightBlueColor = const Color(0xFF42A5F5);

  // List data FAQ
  final List<Map<String, String>> faqList = const [
    {
      'question': 'Bagaimana cara membuat booking?',
      'answer': 'Anda dapat membuat booking melalui menu "Book Service" di halaman utama. Pilih jenis layanan, waktu, dan tanggal yang Anda inginkan.',
    },
    {
      'question': 'Apa saja jenis layanan yang tersedia?',
      'answer': 'Kami menyediakan berbagai layanan mulai dari Service Rutin, Ganti Oli, Perbaikan Umum, hingga Pengecekan Kendaraan.',
    },
    {
      'question': 'Bagaimana cara mengubah booking atau membatalkan booking?',
      'answer': 'Buka menu "History" atau "Schedule", pilih booking yang aktif, dan Anda akan menemukan opsi untuk mengubah atau membatalkan jadwal di sana.',
    },
    {
      'question': 'Bagaimana cara menambahkan spare part ke booking?',
      'answer': 'Spare part dapat ditambahkan saat proses booking awal atau melalui fitur chat setelah booking dikonfirmasi oleh bengkel.',
    },
    {
      'question': 'Apa kebijakan pembatalannya?',
      'answer': 'Pembatalan dapat dilakukan hingga 2 jam sebelum waktu booking yang dijadwalkan tanpa dikenakan biaya. Lewat dari itu, mungkin ada biaya pembatalan.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        elevation: 0,
        centerTitle: true,
        title: const Text('Bantuan', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
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
            // 1. JUDUL FAQ
            const Text(
              'FAQ',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            // 2. DAFTAR FAQ (MENGGUNAKAN EXPANSION TILE)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect( // Menggunakan ClipRRect agar borderRadius berlaku untuk ExpansionTile
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: faqList.map((faq) {
                    return _buildFAQItem(context, faq['question']!, faq['answer']!);
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // 3. HUBUNGI CS CARD
            Container(
              padding: const EdgeInsets.all(20),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.chat_bubble, color: lightBlueColor, size: 30),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Hubungi CS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const Text('Butuh bantuan lebih lanjut?', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: _buildContactButton('Hubungi Kami', () {
                      // Aksi Hubungi CS (misal: buka chat/telepon)
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget Helper: Item FAQ (ExpansionTile)
  Widget _buildFAQItem(BuildContext context, String question, String answer) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent), // Hilangkan divider bawaan ExpansionTile
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        title: Text(
          question,
          style: TextStyle(color: darkBlueColor, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: darkBlueColor,
          size: 16,
        ),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              answer,
              style: const TextStyle(color: Colors.black54, height: 1.5),
            ),
          ),
          const Divider(height: 0, color: Colors.grey), // Tambahkan divider di bawah jawaban
        ],
      ),
    );
  }

  // Widget Helper: Tombol Hubungi Kami (Gradient Biru)
  Widget _buildContactButton(String text, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [lightBlueColor, darkBlueColor], // Gradient dari terang ke gelap
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
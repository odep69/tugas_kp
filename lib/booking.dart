import 'package:flutter/material.dart';
import 'package:projec_kp/home.dart';

// Warna Dasar
const Color darkBlueColor = Color(0xFF0D325E);
const Color lightBlueColor = Color(0xFF42A5F5);
const Color orangeColor = Color(0xFFFF9800);

// =========================================================================
// WIDGET PEMBANTU (Helper Widgets)
// =========================================================================

// AppBar Kustom untuk seluruh alur Booking
PreferredSizeWidget _buildAppBar(BuildContext context, String title, String stepInfo) {
  return AppBar(
    backgroundColor: darkBlueColor,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      onPressed: () => Navigator.pop(context),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          stepInfo,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    ),
  );
}

// Widget untuk tombol pilihan (misal: Service Rutin)
Widget _buildSelectionButton(String text, bool isSelected, VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15.0),
    child: SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.white : Colors.white10,
          foregroundColor: isSelected ? darkBlueColor : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: isSelected ? darkBlueColor : Colors.white30,
              width: 1.5,
            ),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    ),
  );
}

// Widget KHUSUS untuk tombol slot waktu agar ukurannya tidak full-width
Widget _buildTimeSlotButton(String text, bool isSelected, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: isSelected ? Colors.white : Colors.white10,
      foregroundColor: isSelected ? darkBlueColor : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: isSelected ? darkBlueColor : Colors.white30,
          width: 1.5,
        ),
      ),
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  );
}

// =========================================================================
// BOOKING 1: Select Service
// =========================================================================

class BookingStep1Page extends StatefulWidget {
  const BookingStep1Page({super.key});

  @override
  State<BookingStep1Page> createState() => _BookingStep1PageState();
}

class _BookingStep1PageState extends State<BookingStep1Page> {
  String? selectedService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      appBar: _buildAppBar(context, 'Booking 1', 'Step 1 of 3'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Service',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            _buildSelectionButton('Service Rutin', selectedService == 'Rutin', () {
              setState(() {
                selectedService = 'Rutin';
              });
            }),
            _buildSelectionButton('Ganti Oli', selectedService == 'Oli', () {
              setState(() {
                selectedService = 'Oli';
              });
            }),
            _buildSelectionButton('Perbaikan Umum', selectedService == 'Umum', () {
              setState(() {
                selectedService = 'Umum';
              });
            }),

            const Spacer(),

            // Tombol Next
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: selectedService != null
                    ? () {
                        // Navigasi ke Step 2
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BookingStep2Page()),
                        );
                      }
                    : null, // Tombol nonaktif jika belum ada yang dipilih
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightBlueColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
                child: const Text('Next', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// BOOKING 2: Select Date & Time
// =========================================================================

class BookingStep2Page extends StatefulWidget {
  const BookingStep2Page({super.key});

  @override
  State<BookingStep2Page> createState() => _BookingStep2PageState();
}

class _BookingStep2PageState extends State<BookingStep2Page> {
  // 1. Variabel untuk "Bulan yang sedang dilihat" di kalender
  DateTime _focusedMonth = DateTime.now();

  // 2. Variabel untuk "Tanggal lengkap yang dipilih" (Default: hari ini)
  DateTime _selectedDate = DateTime.now();
  
  String? selectedTime;
  final List<String> timeSlots = ['07:00', '09:00', '11:00', '13:00', '15:00', '16:00'];
  final List<String> daysOfWeek = ['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU'];
  final List<String> monthNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  // Fungsi untuk ganti bulan
  void _changeMonth(int offset) {
    setState(() {
      // Menambah atau mengurangi bulan
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + offset, 1);
    });
  }

  // Fungsi helper untuk mendapatkan jumlah hari dalam bulan tersebut
  int _getDaysInMonth(int year, int month) {
    return DateUtils.getDaysInMonth(year, month);
  }

  @override
  Widget build(BuildContext context) {
    // Hitung offset hari pertama (Misal tgl 1 jatuh di hari apa?)
    // weekday: 1 (Senin) ... 7 (Minggu)
    // Kita kurangi 1 agar index array mulai dari 0 untuk Senin
    int firstDayOffset = DateTime(_focusedMonth.year, _focusedMonth.month, 1).weekday - 1;
    int totalDays = _getDaysInMonth(_focusedMonth.year, _focusedMonth.month);

    return Scaffold(
      backgroundColor: darkBlueColor,
      appBar: _buildAppBar(context, 'Booking', 'Step 2 of 3'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Date',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // --- KARTU KALENDER ---
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        // --- HEADER BULAN & NAVIGASI ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Tampilkan Nama Bulan & Tahun secara Dinamis
                            Text(
                              '${monthNames[_focusedMonth.month - 1]} ${_focusedMonth.year}',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Row(
                              children: [
                                // Tombol Mundur Bulan
                                InkWell(
                                  onTap: () => _changeMonth(-1),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.arrow_back_ios, size: 16, color: Colors.grey),
                                  ),
                                ),
                                // Tombol Maju Bulan
                                InkWell(
                                  onTap: () => _changeMonth(1),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        
                        // --- NAMA HARI ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: daysOfWeek.map((day) => Text(
                            day,
                            style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),
                          )).toList(),
                        ),
                        const SizedBox(height: 10),

                        // --- GRID TANGGAL DINAMIS ---
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 42, // 6 baris x 7 hari (maksimal tampilan kalender)
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            childAspectRatio: 1.0,
                          ),
                          itemBuilder: (context, index) {
                            // Logika matematika untuk menentukan tanggal
                            int dayNumber = index - firstDayOffset + 1;

                            // Jika angka di luar range hari bulan ini (negatif atau > total hari)
                            if (dayNumber < 1 || dayNumber > totalDays) {
                              return const SizedBox.shrink();
                            }

                            // Cek apakah tanggal ini adalah tanggal yang dipilih?
                            // Kita harus cek Tahun, Bulan, dan Hari harus cocok
                            bool isSelected = 
                                _selectedDate.year == _focusedMonth.year &&
                                _selectedDate.month == _focusedMonth.month &&
                                _selectedDate.day == dayNumber;

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  // Update tanggal terpilih
                                  _selectedDate = DateTime(_focusedMonth.year, _focusedMonth.month, dayNumber);
                                });
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: isSelected ? const Color(0xFF2979FF) : Colors.transparent, 
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '$dayNumber',
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black87,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- SELECT TIME ---
                  const Text(
                    'Select Time',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),

                  Wrap(
                    spacing: 12.0,
                    runSpacing: 12.0,
                    children: timeSlots.map((time) {
                      bool isSelected = selectedTime == time;
                      return SizedBox(
                        width: 90, 
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedTime = time;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isSelected ? Colors.white : Colors.transparent,
                            foregroundColor: isSelected ? darkBlueColor : Colors.white,
                            side: BorderSide(color: isSelected ? Colors.white : Colors.white38),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(time, style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // --- TOMBOL NEXT ---
          Container(
            padding: const EdgeInsets.all(20.0),
            color: darkBlueColor, 
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: selectedTime != null
                    ? () {
                        // Format Tanggal Dinamis untuk dikirim ke halaman selanjutnya
                        // Contoh: "Friday, 25 Sep 2022"
                        String dayName = daysOfWeek[_selectedDate.weekday - 1]; // Ambil nama hari pendek
                        // Konversi MO -> Monday (Opsional, manual mapping)
                        // Biar simpel kita pakai format custom atau library, disini manual saja:
                        String fullDateStr = "$dayName, ${_selectedDate.day} ${monthNames[_selectedDate.month - 1]} ${_selectedDate.year}";

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingStep3Page(
                              selectedDateStr: fullDateStr,
                              selectedTimeStr: selectedTime!,
                            ),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, 
                  foregroundColor: darkBlueColor, 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                ),
                child: const Text('Next', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// BOOKING 3: Review & Confirm
// =========================================================================

class BookingStep3Page extends StatelessWidget {
  // 1. Tambahkan variabel untuk menampung data yang dikirim
  final String selectedDateStr;
  final String selectedTimeStr;

  const BookingStep3Page({
    super.key, 
    required this.selectedDateStr, 
    required this.selectedTimeStr
  });

  // Widget baris ringkasan
  Widget _buildSummaryRow(String label, String value, {Color valueColor = Colors.white}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 16)),
          Text(value, style: TextStyle(color: valueColor, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      appBar: _buildAppBar(context, 'Booking 3', 'Step 3 of 3'), // Update step info
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Review & Confirm',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            // --- Booking Summary 1 (Waktu & Tanggal) ---
            const Text(
              'Booking Summary',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            
            // Tampilkan Data Dinamis di Sini
            _buildSummaryRow('Service Rutin', selectedDateStr), // Menggunakan data kiriman
            _buildSummaryRow('Time', selectedTimeStr),          // Menggunakan data kiriman
            
            const SizedBox(height: 20),
            Divider(color: Colors.white24),
            const SizedBox(height: 20),
            
            // --- Booking Summary 2 (Harga) ---
            const Text(
              'Payment Detail',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildSummaryRow('Service', 'Rp.100.000'),
            _buildSummaryRow('Spare Part', 'Available', valueColor: Colors.green),
            Divider(color: Colors.white10),
            _buildSummaryRow('Total', 'Rp.100.000', valueColor: lightBlueColor),

            const Spacer(),

            // Teks Persetujuan
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                  children: [
                    const TextSpan(text: 'By confirming you agree to our '),
                    TextSpan(
                      text: 'Terms and Conditions',
                      style: TextStyle(color: lightBlueColor, decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
            ),

            // Tombol Confirm
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // KIRIM DATA KE HALAMAN DETAIL (BookingStep4Page)
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingStep4Page(
                        dateStr: selectedDateStr, // Kirim tanggal dari step 3
                        timeStr: selectedTimeStr, // Kirim waktu dari step 3
                        serviceName: 'Service Rutin', // Bisa diganti variabel jika ada
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  // ... (style sama seperti sebelumnya)
                  backgroundColor: lightBlueColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
                child: const Text('Confirm', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// BOOKING 4: Detail Booking
// =========================================================================

class BookingStep4Page extends StatelessWidget {
  // 1. Terima data dari halaman sebelumnya
  final String dateStr;
  final String timeStr;
  final String serviceName;

  const BookingStep4Page({
    super.key,
    required this.dateStr,
    required this.timeStr,
    this.serviceName = 'Service Rutin', // Default nama service
  });

  // Widget Status Tag
  Widget _buildStatusTag(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      // AppBar tanpa tombol back otomatis, kita ganti fungsi Home
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        elevation: 0,
        automaticallyImplyLeading: false, // Hilangkan tombol back default
        title: const Text(
          'Booking',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
               // Aksi tombol silang: Kembali ke Home
               Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()), // Pastikan import home_page.dart
                (route) => false,
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detail Booking',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            // --- KARTU DETAIL BOOKING (DATA DINAMIS) ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '#XX-8211',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkBlueColor),
                      ),
                      _buildStatusTag('Disetujui'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // Tampilkan Nama Service
                  Text(
                    serviceName,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 5),
                  // Tampilkan Tanggal & Jam yang Dipilih
                  Text(
                    '$dateStr\n$timeStr', 
                    style: const TextStyle(fontSize: 16, color: Colors.black54, height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // --- Tombol Aksi (Reschedule & Cancel) ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: OutlinedButton(
                      onPressed: () {
                         // Navigasi ke Reschedule (BookingStep5Page)
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BookingStep5Page()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: lightBlueColor,
                        side: const BorderSide(color: lightBlueColor),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      ),
                      child: const Text('Reschedule'),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: OutlinedButton(
                      onPressed: () {
                        // Logika Cancel
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // --- TOMBOL BACK TO HOME ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // --- PERUBAHAN DI SINI ---
                  // Kembali ke Menu Home MEMBAWA DATA BOOKING
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        bookedServiceName: serviceName, // Kirim Nama Service
                        bookedDate: dateStr,            // Kirim Tanggal
                        bookedTime: timeStr,            // Kirim Jam
                      ),
                    ),
                    (route) => false, // Hapus semua history halaman sebelumnya
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightBlueColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  elevation: 5,
                ),
                child: const Text('Back to Home', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// BOOKING 5: Reschedule
// =========================================================================

class BookingStep5Page extends StatelessWidget {
  const BookingStep5Page({super.key});

  // Widget baris waktu reschedule
  Widget _buildRescheduleTimeRow(String time, String date, String status, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white12)),
        color: isSelected ? darkBlueColor.withOpacity(0.5) : Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Kolom Kiri: Waktu & Tanggal
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          
          // Kolom Kanan: Status
          Text(
            status,
            style: TextStyle(
              color: status == 'Approved' ? Colors.green : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      appBar: _buildAppBar(context, 'Booking', ''),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reschedule',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // --- Daftar Slot Waktu Reschedule ---
            _buildRescheduleTimeRow('10:00', '7 Oct', 'Booked'),
            _buildRescheduleTimeRow('11:30', '7 Oct', 'Approved', isSelected: true),
            _buildRescheduleTimeRow('14:00', '7 Oct', 'Schedule'),
            
            const SizedBox(height: 30),
            
            // --- Detail Jadwal Saat Ini ---
            const Text(
              'Schedule',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 5),
            const Text(
              'Friday, 14 Oct\n11:00',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
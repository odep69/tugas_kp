import 'package:flutter/material.dart';

// --- MODEL DATA BARANG ---
class InventoryItem {
  final String name;
  final String price;
  final String status;
  final bool isInStock;
  final String imagePath; // Menggunakan IconData untuk contoh, bisa diganti Image

  InventoryItem({
    required this.name,
    required this.price,
    required this.status,
    required this.isInStock,
    required this.imagePath,
  });
}

// =============================================================================
// HALAMAN 1: INVENTORY LIST (KIRI)
// =============================================================================
class InventoryListPage extends StatefulWidget {
  const InventoryListPage({super.key});

  @override
  State<InventoryListPage> createState() => _InventoryListPageState();
}

class _InventoryListPageState extends State<InventoryListPage> {
  final Color darkBlueColor = const Color(0xFF0D325E);
  
  // Dummy Data (Sesuai gambar)
  final List<InventoryItem> items = [
    InventoryItem(
      name: 'Oil Shell Adv',
      price: 'Rp. 65.000',
      status: 'In Stock',
      isInStock: true,
      imagePath: 'assets/oil.png', // Placeholder logic
    ),
    InventoryItem(
      name: 'Spark Plug',
      price: 'Rp. 50.000',
      status: 'Out of Stock',
      isInStock: false,
      imagePath: 'assets/plug.png',
    ),
     InventoryItem(
      name: 'Air Filter',
      price: 'Rp. 70.000',
      status: 'In Stock',
      isInStock: true,
      imagePath: 'assets/filter.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      // AppBar dengan Back Button sesuai desain
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        elevation: 0,
        centerTitle: true,
        title: const Text('Inventory', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context), // Kembali ke Home
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // 1. SEARCH BAR
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

                // 2. FILTER CHIPS
                Row(
                  children: [
                    _buildFilterButton('All', true),
                    const SizedBox(width: 10),
                    _buildFilterButton('In Stock', false),
                    const SizedBox(width: 10),
                    _buildFilterButton('Out of Stock', false),
                  ],
                ),
              ],
            ),
          ),

          // 3. LIST BARANG
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return GestureDetector(
                  onTap: () {
                    // PINDAH KE HALAMAN DETAIL (KANAN)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InventoryDetailPage(item: item),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(12),
                    // Jika desain list transparan:
                    color: Colors.transparent, 
                    // Jika ingin pakai card putih seperti "Oil Shell":
                    // decoration: BoxDecoration(color: Colors.transparent), 
                    
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Gambar Item (Kotak Putih)
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                          ),
                          // Placeholder Icon ganti Image.asset jika ada gambar
                          child: Icon(Icons.inventory_2, color: darkBlueColor, size: 30), 
                        ),
                        const SizedBox(width: 15),
                        
                        // Detail Teks
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                  color: Colors.white, 
                                  fontSize: 18, 
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(height: 5),
                              // Tag Status
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: item.isInStock ? const Color(0xFFC8E6C9) : const Color(0xFFFFCDD2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  item.status,
                                  style: TextStyle(
                                    color: item.isInStock ? Colors.green[800] : Colors.red[800],
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Harga
                        Text(
                          item.price,
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

   
          
        ],
      ),
    );
  }

  // Widget Helper untuk Filter Button (All, In Stock, dll)
  Widget _buildFilterButton(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF536DFE) : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// =============================================================================
// HALAMAN 2: INVENTORY DETAIL (KANAN)
// =============================================================================
class InventoryDetailPage extends StatelessWidget {
  final InventoryItem item;
  final Color darkBlueColor = const Color(0xFF0D325E);

  const InventoryDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        elevation: 0,
        centerTitle: true,
        title: const Text('Inventory', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. GAMBAR BESAR
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                // Placeholder gambar besar (Ganti Image.asset sesuai kebutuhan)
                child: Icon(Icons.category, size: 100, color: darkBlueColor),
              ),
            ),
            const SizedBox(height: 30),

            // 2. NAMA BARANG
            Text(
              item.name,
              style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),

            // 3. HARGA
            Text(
              item.price,
              style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 15),

            // 4. STATUS TAG
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: item.isInStock ? const Color(0xFFC8E6C9) : const Color(0xFFFFCDD2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                item.status,
                style: TextStyle(
                  color: item.isInStock ? Colors.green[800] : Colors.red[800],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // 5. COMPATIBILITY & DESCRIPTION
            const Text(
              'Compability', // Sesuai teks di gambar desain
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Sustainable for most motor',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),

            const Spacer(),

            // 6. TOMBOL ADD TO BOOKING
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Aksi Add to Booking
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${item.name} added to booking'),
                    duration: const Duration(seconds: 1),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Tombol Putih
                  foregroundColor: darkBlueColor, // Teks Biru Gelap
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Add to Booking', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
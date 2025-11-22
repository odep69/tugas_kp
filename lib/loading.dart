// lib/loading_screen.dart
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:projec_kp/home.dart'; // Import halaman tujuan

class LoadingScreen extends StatefulWidget {
  final Widget nextPage; // Halaman tujuan setelah loading

  const LoadingScreen({super.key, required this.nextPage});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final Color darkBlueColor = const Color(0xFF0D325E);
  final Color lightBlueColor = const Color(0xFF42A5F5);

  @override
  void initState() {
    super.initState();
    // Panggil fungsi untuk menunggu dan menavigasi
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    // Simulasi proses loading/autentikasi selama 2 detik
    await Future.delayed(const Duration(seconds: 2));

    // Navigasi ke halaman tujuan (misal: HomePage)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget.nextPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'MYBengkel',
              style: TextStyle(
                color: darkBlueColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(lightBlueColor),
                strokeWidth: 5,
                backgroundColor: lightBlueColor.withOpacity(0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// lib/register_page.dart
import 'package:flutter/material.dart';
import 'package:projec_kp/home.dart';
import 'package:projec_kp/loading.dart';
import 'package:projec_kp/login.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  final Color darkBlueColor = const Color(0xFF0D325E);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: darkBlueColor,
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: darkBlueColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white), // Untuk panah kembali
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: screenHeight - kToolbarHeight - MediaQuery.of(context).padding.top),
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: screenHeight * 0.1),
              const Text(
                'MYBengkel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.1),

              // --- Field Full Name ---
              _buildRoundedInputField(
                hintText: 'Full Name',
                icon: Icons.person,
              ),
              const SizedBox(height: 15.0),

              // --- Field Email/Phone ---
              _buildRoundedInputField(
                hintText: 'Email/Phone',
                icon: Icons.email,
              ),
              const SizedBox(height: 15.0),

              // --- Field Password ---
              _buildRoundedInputField(
                hintText: 'Password',
                icon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 15.0),

              // --- Field Confirm Password ---
              _buildRoundedInputField(
                hintText: 'Confirm Password',
                icon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 40.0),

              // --- Tombol Register ---
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigasi ke LoadingScreen dengan tujuan akhir HomePage 
                    // (simulasi registrasi berhasil dan langsung masuk)
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoadingScreen(
                            nextPage: HomePage(),
                          )),
                      (Route<dynamic> route) => false,
                    );
                  },
                  // ... (style tombol)
                  child: const Text('Register', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),

              const SizedBox(height: 60.0), // Spasi sebelum teks "Already have an account?"

              // --- Teks "Already have an account?" dan "Login" ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigasi ke LoadingScreen dengan tujuan akhir LoginPage
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoadingScreen(
                              nextPage: LoginPage(), // Tujuan: Halaman Login
                            )),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xFFFF9800), 
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              // ...
            ],
          ),
        ),
      ),
    );
  }

  // Widget pembantu untuk TextField dengan border bulat dan ikon
  Widget _buildRoundedInputField({
    required String hintText,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Latar belakang putih
        borderRadius: BorderRadius.circular(8.0), // Sudut bulat
      ),
      child: TextField(
        obscureText: isPassword,
        style: TextStyle(color: darkBlueColor), // Warna teks input sesuai latar
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: darkBlueColor.withOpacity(0.7)),
          prefixIcon: Icon(icon, color: darkBlueColor),
          border: InputBorder.none, // Hilangkan border default
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
        ),
      ),
    );
  }
}
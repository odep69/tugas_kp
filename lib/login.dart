// lib/main.dart (Hanya bagian LoginPage yang relevan)
import 'package:flutter/material.dart';
// Import halaman registrasi yang baru dibuat
import 'package:projec_kp/register.dart'; // Sesuaikan dengan nama proyek Anda
import 'package:projec_kp/home.dart';
import 'package:projec_kp/loading.dart';

void main() {
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'MYBengkel Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  final Color darkBlueColor = const Color(0xFF0D325E);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: darkBlueColor,
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white), 
        ),
        backgroundColor: darkBlueColor, 
        elevation: 0, 
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
              
              SizedBox(height: screenHeight * 0.15),
              
              _buildInputField(
                hintText: 'Email/No Hp',
              ),
              
              const SizedBox(height: 20.0),
              
              _buildInputField(
                hintText: 'Password',
                isPassword: true,
              ),

              const SizedBox(height: 40.0),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigasi ke LoadingScreen dengan tujuan akhir HomePage
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoadingScreen(
                            nextPage: HomePage(),
                          )),
                    );
                  },
                  // ... (style tombol) ...
                  child: const Text('Login', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),

              const SizedBox(height: 20.0),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Logika Google Login
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white, 
                    foregroundColor: Colors.black54, 
                    side: const BorderSide(color: Colors.white), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  icon: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Google_Favicon_2025.svg/1175px-Google_Favicon_2025.svg.png',
                    height: 20.0,
                  ),
                  label: const Text(
                    'Continue with Google',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30.0),

              GestureDetector(
                onTap: () {
                  // Navigasi ke halaman lupa password
                },
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 10.0),

              // --- Ubah bagian ini untuk navigasi ke halaman registrasi ---
              GestureDetector(
                onTap: () {
                  // Navigasi ke LoadingScreen dengan tujuan akhir RegisterPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoadingScreen(
                          nextPage: RegisterPage(), // Tujuan: Halaman Register
                        )),
                  );
                },
                child: const Text(
                  'Create account',
                  style: TextStyle(
                    color: Color(0xFFFF9800), 
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // ...
            ],
          ),
        ),
      ),
    );
  }
  // ... (widget _buildInputField)


  Widget _buildInputField({
    required String hintText,
    bool isPassword = false,
  }) {
    return TextField(
      obscureText: isPassword, 
      style: const TextStyle(color: Colors.white), 
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70), 
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white70),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
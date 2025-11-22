// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Impor login.dart karena di sanalah MyApp dan LoginPage berada.
import 'package:projec_kp/login.dart';

void main() {
  // Nama tes diubah agar lebih deskriptif sesuai dengan fungsinya.
  testWidgets('Login page UI test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verifikasi bahwa judul AppBar adalah 'Login'.
    expect(find.text('Login'), findsOneWidget);

    // Verifikasi bahwa judul aplikasi 'MYBengkel' ada di halaman.
    expect(find.text('MYBengkel'), findsOneWidget);

    // Verifikasi bahwa ada dua kolom input (Email/No Hp dan Password).
    // Kita bisa mencarinya berdasarkan hintText.
    expect(find.widgetWithText(TextField, 'Email/No Hp'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);

    // Verifikasi bahwa tombol 'Create account' ada.
    expect(find.text('Create account'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Import home_screen.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pengingat Jadwal Obat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(), // Menjadikan HomeScreen sebagai halaman utama
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/medication.dart';

class ApiService {
  static const String baseUrl = 'http://localhost/api'; // Sesuaikan dengan URL backend Anda

  // Fungsi untuk mengambil daftar obat
  static Future<List<Medication>> getMedications() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/medications'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        // Parse data JSON
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Medication.fromMap(item)).toList(); // Menggunakan fromMap untuk mendekode
      } else {
        print('Gagal mengambil data: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Exception: $e');
      return [];
    }
  }

  // Fungsi untuk menambahkan obat ke backend
  static Future<bool> addMedication(Medication medication) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/medications'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(medication.toJson()), // Mengirim objek dalam format JSON
      );

      if (response.statusCode == 201) {
        return true; // Berhasil menambahkan
      } else {
        print('Gagal menambahkan obat: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }
}

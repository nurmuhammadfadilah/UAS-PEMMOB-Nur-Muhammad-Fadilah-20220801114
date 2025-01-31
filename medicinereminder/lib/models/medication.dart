class Medication {
  final String name;
  final String time;
  bool isChecked; // Tambahkan status untuk apakah obat sudah diminum

  Medication({required this.name, required this.time, this.isChecked = false});

  // Menambahkan factory constructor untuk mengonversi map (JSON) ke objek Medication
  factory Medication.fromMap(Map<String, dynamic> map) {
    return Medication(
      name: map['name'],
      time: map['time'],
      isChecked: map['is_checked'] ?? false, // Jika tidak ada is_checked, default false
    );
  }

  // Method untuk mengubah objek menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'time': time,
      'is_checked': isChecked, // Menyertakan status isChecked dalam JSON
    };
  }
}

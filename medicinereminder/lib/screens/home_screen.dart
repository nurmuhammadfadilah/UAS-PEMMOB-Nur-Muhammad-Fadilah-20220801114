import 'package:flutter/material.dart';
import '../models/medication.dart';
import '../services/api_service.dart';
import 'add_medication_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Medication> medications = [];
  bool _isLoading = false;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void _loadMedications() async {
    setState(() {
      _isLoading = true;
    });

    List<Medication> fetchedMedications = await ApiService.getMedications();

    // Urutkan daftar obat berdasarkan waktu (paling awal dulu)
    fetchedMedications.sort((a, b) {
      final timeA = _convertTimeToDateTime(a.time);
      final timeB = _convertTimeToDateTime(b.time);
      return timeA.compareTo(timeB);
    });

    setState(() {
      medications = fetchedMedications;
      _isLoading = false;
    });
  }

  DateTime _convertTimeToDateTime(String time) {
    final currentDate = DateTime.now();
    final timeParts = time.split(':');
    return DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      int.parse(timeParts[0]),
      int.parse(timeParts[1]),
    );
  }

  bool _isMedicationTimePassed(String medicationTime) {
    final currentTime = DateTime.now();
    final medicationTimeObj = _convertTimeToDateTime(medicationTime);
    return medicationTimeObj.isBefore(currentTime);
  }

  void _removeCheckedMedication(int index) {
    final removedMedication = medications[index];
    medications.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildAnimatedItem(removedMedication, animation),
    );
  }

  Widget _buildAnimatedItem(Medication medication, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      axisAlignment: 0.0,
      child: FadeTransition(
        opacity: animation,
        child: _buildMedicationCard(medication, medications.indexOf(medication)),
      ),
    );
  }

  Widget _buildMedicationCard(Medication medication, int index) {
    final isTimePassed = _isMedicationTimePassed(medication.time);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        leading: Icon(
          Icons.medication,
          color: Colors.blueAccent,
          size: 32,
        ),
        title: Text(
          medication.name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          'Waktu: ${medication.time}',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        trailing: isTimePassed
            ? Checkbox(
                value: medication.isChecked,
                onChanged: (bool? value) {
                  if (value == true) {
                    _removeCheckedMedication(index);
                  }
                },
              )
            : Icon(
                Icons.lock_clock,
                color: Colors.grey[400],
              ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadMedications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Jadwal Obat', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: AnimatedList(
                      key: _listKey,
                      initialItemCount: medications.length,
                      itemBuilder: (context, index, animation) {
                        return _buildAnimatedItem(medications[index], animation);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddMedicationScreen(),
                          ),
                        );
                        if (result == true) {
                          _loadMedications();
                        }
                      },
                      label: const Text('Tambah Obat', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,  color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

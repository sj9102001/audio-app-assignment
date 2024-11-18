import 'package:flutter/material.dart';
import '../models/program.dart';
import '../services/program_service.dart';

class ProgramViewModel extends ChangeNotifier {
  final ProgramService _service = ProgramService();
  List<Program> programs = [];
  bool isLoading = false;

  Future<void> fetchPrograms() async {
    isLoading = true;
    notifyListeners();
    try {
      print(programs);
      programs = await _service.fetchPrograms();
    } catch (e) {
      print("Error fetching programs: $e");
    }
    isLoading = false;
    notifyListeners();
  }
}

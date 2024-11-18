import '../models/program.dart';
import 'api_service.dart';

class ProgramService {
  final ApiService _apiService = ApiService();

  Future<List<Program>> fetchPrograms() async {
    final data = await _apiService.get('/programs');
    return (data as List).map((item) => Program.fromJson(item)).toList();
  }
}

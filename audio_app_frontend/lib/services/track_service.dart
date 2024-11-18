import '../models/track.dart';
import 'api_service.dart';

class TrackService {
  final ApiService _apiService = ApiService();

  Future<List<Track>> fetchTracks(String programId) async {
    final data = await _apiService.get('/tracks/$programId');
    return (data as List).map((item) => Track.fromJson(item)).toList();
  }
}

import 'package:flutter/material.dart';
import '../models/track.dart';
import '../services/track_service.dart';

class TrackViewModel extends ChangeNotifier {
  final TrackService _service = TrackService();
  List<Track> tracks = [];
  bool isLoading = false;

  Future<void> fetchTracks(String programId) async {
    isLoading = true;
    notifyListeners();
    try {
      tracks = await _service.fetchTracks(programId);
    } catch (e) {
      print("Error fetching tracks: $e");
    }
    isLoading = false;
    notifyListeners();
  }
}

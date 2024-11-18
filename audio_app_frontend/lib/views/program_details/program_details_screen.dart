import 'package:audio_app_frontend/views/audio_player/audio_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/track_viewmodel.dart';

class ProgramDetailsScreen extends StatefulWidget {
  final String programId;
  final String description;
  final String name;

  ProgramDetailsScreen({required this.programId, required this.description, required this.name});

  @override
  _ProgramDetailsScreenState createState() => _ProgramDetailsScreenState();
}

class _ProgramDetailsScreenState extends State<ProgramDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger data fetch when the screen loads
    Future.microtask(() {
      final viewModel = context.read<TrackViewModel>();
      viewModel.fetchTracks(widget.programId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TrackViewModel>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: viewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : viewModel.tracks.isEmpty
          ? Center(child: Text("No Tracks Available", style: TextStyle(color: Colors.white)))
          : Column(
        children: [
          // Hero Section
          Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/scenery.jpg"), // Replace with the program's image URL
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    widget.name, // Replace with program title
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Description Section
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey.shade900,
            child: Text(
              widget.description,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),

          // Tracks List
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.tracks.length,
              itemBuilder: (context, index) {
                final track = viewModel.tracks[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                        MaterialPageRoute(
                          builder: (context) => AudioPlayerScreen(
                              audioFileUrl: track.audioFileUrl,
                              subtitle: track.description, // Pass description
                              title: track.title
                          ),
                        ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade800, width: 1),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              track.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              track.description,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Footer Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Deepen your practice",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // Back Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

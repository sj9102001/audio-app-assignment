import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final String audioFileUrl;

  AudioPlayerScreen({
    required this.title,
    required this.subtitle,
    required this.audioFileUrl,
  });

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false; // To manage play/pause state
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        totalDuration = duration;
      });
    });
    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        currentPosition = position;
      });
    });
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
        currentPosition = Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _audioPlayer.dispose();
    super.dispose();
  }

  void playPauseAudio() async {
    print("Playing");
    if(isPlaying) {
      await _audioPlayer.pause();
    }else{
      await _audioPlayer.play(UrlSource(widget.audioFileUrl));
    }
    setState(() {
      isPlaying=!isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.yellow],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ),

            // Image and Title Section
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.subtitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16), // Apply rounded corners
                    child: Image.asset(
                      "assets/scenery_2.jpg",
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            // Audio Player Section
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.share, color: Colors.black),
                              onPressed: () {
                                // Share functionality
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.favorite_border, color: Colors.black),
                              onPressed: () {
                                // Favorite functionality
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Slider(
                    value: currentPosition.inSeconds.toDouble(),
                    onChanged: (value) async {
                      final newPosition = Duration(seconds: value.toInt());
                      await _audioPlayer.seek(newPosition);
                      setState(() {
                        currentPosition = newPosition;
                      });
                    },
                    activeColor: Colors.black,
                    inactiveColor: Colors.black38,
                    max: totalDuration.inSeconds.toDouble(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatDuration(currentPosition), // Replace with dynamic current time
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          formatDuration(totalDuration), // Replace with dynamic total duration
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  // Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: playPauseAudio,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            size: 40,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}

import 'package:audio_app_frontend/views/audio_player/audio_player_screen.dart';
import 'package:audio_app_frontend/views/program_details/program_details_screen.dart';
import 'package:audio_app_frontend/views/program_list/program_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/program_viewmodel.dart';
import 'viewmodels/track_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProgramViewModel()),
        ChangeNotifierProvider(create: (_) => TrackViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inner Bhakti',
      initialRoute: '/',
      routes: {
        '/': (context) => ProgramListScreen(),
        '/program-details': (context) => ProgramDetailsScreen(
              programId: ModalRoute.of(context)!.settings.arguments as String,
              description: ModalRoute.of(context)!.settings.arguments as String,
              name: ModalRoute.of(context)!.settings.arguments as String
        ),
        '/audio-player': (context) => AudioPlayerScreen(
              audioFileUrl:
                  ModalRoute.of(context)!.settings.arguments as String,
                  title: ModalRoute.of(context)!.settings.arguments as String,
                  subtitle: ModalRoute.of(context)!.settings.arguments as String,
            ),
      },
    );
  }
}

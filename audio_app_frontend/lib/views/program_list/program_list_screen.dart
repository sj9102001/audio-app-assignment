import 'package:audio_app_frontend/views/program_details/program_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/program_viewmodel.dart';
import './widgets/program_card.dart'; // Import ProgramCard

class ProgramListScreen extends StatefulWidget {
  @override
  _ProgramListScreenState createState() => _ProgramListScreenState();
}

class _ProgramListScreenState extends State<ProgramListScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger data fetch
    Future.microtask(() {
      final viewModel = context.read<ProgramViewModel>();
      viewModel.fetchPrograms();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProgramViewModel>();

    return Scaffold(
      body: Column(
        children: [
          // Header Section
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.orange.shade100,
                  Theme.of(context).scaffoldBackgroundColor, // Default scaffold color
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // AppBar-Like Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.brightness_5, color: Colors.orange),
                          SizedBox(width: 8),
                          Text(
                            "InnerBhakti",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100)),
                            child: IconButton(
                              onPressed: () {
                                // Handle refresh action
                              },
                              icon: Icon(Icons.refresh, color: Colors.black87,),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100)),
                            child: IconButton(
                              onPressed: () {
                                // Handle add action
                              },
                              icon: Icon(Icons.add, color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Prarthana Plans Title
                  Text(
                    "Prarthana Plans",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Program List Section
          Expanded(
            child: viewModel.isLoading
                ? Center(child: CircularProgressIndicator())
                : viewModel.programs.isEmpty
                ? Center(child: Text("No Programs Available"))
                : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: viewModel.programs.length,
                itemBuilder: (context, index) {
                  final program = viewModel.programs[index];
                  return ProgramCard(
                    imageUrl: program.imageUrl,
                    name: program.name,
                    subtitle: program.duration,
                    isLocked: false, // Set to false
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProgramDetailsScreen(
                            programId: program.id,
                            description: program.description, // Pass description
                            name: program.name
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Explore tab
        onTap: (index) {
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book, size: 40),
            label: 'Guide',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            activeIcon: Icon(Icons.explore, color: Colors.orange, size: 40,),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 40),
            label: 'Me',
          ),
        ],
      ),
    );
  }
}

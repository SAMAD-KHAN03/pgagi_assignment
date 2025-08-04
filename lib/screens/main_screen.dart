import 'package:flutter/material.dart';
import 'package:pgagi_assignment/models/startup_idea.dart';
import 'package:pgagi_assignment/screens/idea_listing_screen.dart';
import 'package:pgagi_assignment/screens/idea_submission_screen.dart';
import 'package:pgagi_assignment/screens/leader_board_screen.dart';
import 'package:pgagi_assignment/utils/data_service.dart';

class MainScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const MainScreen({Key? key, required this.isDarkMode, required this.toggleTheme}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  List<StartupIdea> ideas = [];

  @override
  void initState() {
    super.initState();
    _loadIdeas();
  }

  _loadIdeas() async {
    List<StartupIdea> loadedIdeas = await DataService.getIdeas();
    setState(() {
      ideas = loadedIdeas;
    });
  }

  void _addIdea(StartupIdea idea) async {
    await DataService.saveIdea(idea);
    _loadIdeas();
  }

  void _updateIdea(StartupIdea idea) async {
    await DataService.updateIdea(idea);
    _loadIdeas();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      IdeaSubmissionScreen(onSubmit: _addIdea),
      IdeaListingScreen(ideas: ideas, onUpdate: _updateIdea, isDarkMode: widget.isDarkMode),
      LeaderboardScreen(ideas: ideas, isDarkMode: widget.isDarkMode),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: widget.isDarkMode ? Colors.black26 : Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          backgroundColor: widget.isDarkMode ? Colors.grey[850] : Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              activeIcon: Icon(Icons.add_circle),
              label: 'Submit',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb_outline),
              activeIcon: Icon(Icons.lightbulb),
              label: 'Ideas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard_outlined),
              activeIcon: Icon(Icons.leaderboard),
              label: 'Leaderboard',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: widget.toggleTheme,
        backgroundColor: Colors.purple,
        child: Icon(
          widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
          color: Colors.white,
        ),
      ),
    );
  }
}

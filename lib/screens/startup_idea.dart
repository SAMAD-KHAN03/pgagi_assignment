import 'package:flutter/material.dart';
import 'package:pgagi_assignment/screens/main_screen.dart';
import 'package:pgagi_assignment/themes/app_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartupIdeasApp extends StatefulWidget {
  const StartupIdeasApp({super.key});
  @override
  State<StatefulWidget> createState() => _StartupIdeasAppState();
}

class _StartupIdeasAppState extends State<StartupIdeasApp> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  _toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = !isDarkMode;
    });
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Ideas Hub',
      theme: isDarkMode ? AppThemes.darkTheme : AppThemes.lightTheme,
      home: MainScreen(isDarkMode: isDarkMode, toggleTheme: _toggleTheme),
      debugShowCheckedModeBanner: false,
    );
  }
}

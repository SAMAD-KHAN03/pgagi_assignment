import 'dart:convert';
import 'package:pgagi_assignment/models/startup_idea.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataService {
  static const String _ideasKey = 'startup_ideas';
  static const String _userIdKey = 'user_id';

  static Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(_userIdKey);
    if (userId == null) {
      userId = DateTime.now().millisecondsSinceEpoch.toString();
      await prefs.setString(_userIdKey, userId);
    }
    return userId;
  }

  static Future<void> saveIdea(StartupIdea idea) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<StartupIdea> ideas = await getIdeas();
    ideas.insert(0, idea);
    
    List<String> jsonList = ideas.map((idea) => jsonEncode(idea.toJson())).toList();
    await prefs.setStringList(_ideasKey, jsonList);
  }

  static Future<List<StartupIdea>> getIdeas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList(_ideasKey);
    
    if (jsonList == null) return [];
    
    return jsonList.map((jsonStr) => StartupIdea.fromJson(jsonDecode(jsonStr))).toList();
  }

  static Future<void> updateIdea(StartupIdea updatedIdea) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<StartupIdea> ideas = await getIdeas();
    
    int index = ideas.indexWhere((idea) => idea.id == updatedIdea.id);
    if (index != -1) {
      ideas[index] = updatedIdea;
      List<String> jsonList = ideas.map((idea) => jsonEncode(idea.toJson())).toList();
      await prefs.setStringList(_ideasKey, jsonList);
    }
  }
}
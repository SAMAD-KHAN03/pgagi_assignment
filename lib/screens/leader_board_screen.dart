import 'package:flutter/material.dart';
import 'package:pgagi_assignment/models/startup_idea.dart';
import 'package:pgagi_assignment/widgets/empty_state.dart';
import 'package:pgagi_assignment/widgets/leader_board_card.dart';
import 'package:pgagi_assignment/widgets/section_header.dart';

class LeaderboardScreen extends StatelessWidget {
  final List<StartupIdea> ideas;
  final bool isDarkMode;

  const LeaderboardScreen({Key? key, required this.ideas, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get top 5 ideas by votes
    List<StartupIdea> topByVotes = List.from(ideas);
    topByVotes.sort((a, b) => b.votes.compareTo(a.votes));
    topByVotes = topByVotes.take(5).toList();

    // Get top 5 ideas by rating
    List<StartupIdea> topByRating = List.from(ideas);
    topByRating.sort((a, b) => b.aiRating.compareTo(a.aiRating));
    topByRating = topByRating.take(5).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('🏆 Leaderboard', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ideas.isEmpty
          ? EmptyStateWidget()
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.amber, Colors.orange],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.3),
                          blurRadius: 15,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.emoji_events, color: Colors.white, size: 40),
                        SizedBox(height: 12),
                        Text(
                          'Top Performing Ideas',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Celebrating innovation and community support',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 30),
                  
                  // Top by Votes
                  SectionHeader(title:'🗳️ Most Voted',color:  Colors.green),
                  SizedBox(height: 16),
                  ...topByVotes.asMap().entries.map((entry) {
                    return LeaderboardCard(
                      idea: entry.value,
                      rank: entry.key + 1,
                      type: 'votes',
                      isDarkMode: isDarkMode,
                    );
                  }).toList(),
                  
                  SizedBox(height: 30),
                  
                  // Top by Rating
                  SectionHeader(title:'⭐ Highest Rated',color:  Colors.blue),
                  SizedBox(height: 16),
                  ...topByRating.asMap().entries.map((entry) {
                    return LeaderboardCard(
                      idea: entry.value,
                      rank: entry.key + 1,
                      type: 'rating',
                      isDarkMode: isDarkMode,
                    );
                  }).toList(),
                  
                  SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

}

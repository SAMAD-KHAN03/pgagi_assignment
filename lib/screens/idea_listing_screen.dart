import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pgagi_assignment/models/startup_idea.dart';
import 'package:pgagi_assignment/screens/idea_card.dart';
import 'package:pgagi_assignment/utils/data_service.dart';
import 'package:pgagi_assignment/widgets/empty_state.dart';

class IdeaListingScreen extends StatefulWidget {
  final List<StartupIdea> ideas;
  final Function(StartupIdea) onUpdate;
  final bool isDarkMode;

  const IdeaListingScreen({
    Key? key,
    required this.ideas,
    required this.onUpdate,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  _IdeaListingScreenState createState() => _IdeaListingScreenState();
}

class _IdeaListingScreenState extends State<IdeaListingScreen> {
  String _sortBy = 'rating'; // 'rating' or 'votes'
  
  @override
  Widget build(BuildContext context) {
    List<StartupIdea> sortedIdeas = List.from(widget.ideas);
    
    if (_sortBy == 'rating') {
      sortedIdeas.sort((a, b) => b.aiRating.compareTo(a.aiRating));
    } else {
      sortedIdeas.sort((a, b) => b.votes.compareTo(a.votes));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('💡 Startup Ideas (${widget.ideas.length})', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.sort),
            onSelected: (value) {
              setState(() {
                _sortBy = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'rating',
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange),
                    SizedBox(width: 8),
                    Text('Sort by Rating'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'votes',
                child: Row(
                  children: [
                    Icon(Icons.thumb_up, color: Colors.green),
                    SizedBox(width: 8),
                    Text('Sort by Votes'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: sortedIdeas.isEmpty
          ? EmptyStateWidget()
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: sortedIdeas.length,
              itemBuilder: (context, index) {
                return IdeaCard(
                  idea: sortedIdeas[index],
                  onVote: _handleVote,
                  onShare: _handleShare,
                  isDarkMode: widget.isDarkMode,
                );
              },
            ),
    );
  }


  void _handleVote(StartupIdea idea) async {
    String userId = await DataService.getUserId();
    
    if (idea.votedUsers.contains(userId)) {
      _showToast('You have already voted for this idea!', isSuccess: false);
      return;
    }

    idea.votes++;
    idea.votedUsers.add(userId);
    widget.onUpdate(idea);
    
    HapticFeedback.lightImpact();
    _showToast('👍 Vote added successfully!');
  }

  void _handleShare(StartupIdea idea) {
    final shareText = '''
🚀 Check out this startup idea!

${idea.name}
${idea.tagline}

AI Rating: ${idea.aiRating}/100
Votes: ${idea.votes}

${idea.description}
    ''';
    
    Clipboard.setData(ClipboardData(text: shareText));
    _showToast('📋 Idea copied to clipboard!');
  }

  void _showToast(String message, {bool isSuccess = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pgagi_assignment/models/startup_idea.dart';

class LeaderboardCard extends StatelessWidget {
  final StartupIdea idea;
  final int rank;
  final String type; // 'votes' or 'rating'
  final bool isDarkMode;

  const LeaderboardCard({
    Key? key,
    required this.idea,
    required this.rank,
    required this.type,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black26 : Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
        border: rank <= 3 ? Border.all(color: _getRankColor(), width: 2) : null,
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            // Rank Badge
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _getRankGradient(),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _getRankColor().withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: rank <= 3
                    ? Text(_getRankEmoji(), style: TextStyle(fontSize: 24))
                    : Text(
                        '$rank',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),

            SizedBox(width: 16),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    idea.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    idea.tagline,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'AI: ${idea.aiRating}/100',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.blue[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${idea.votes} votes',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.green[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Score
            Column(
              children: [
                Icon(
                  type == 'votes' ? Icons.thumb_up : Icons.star,
                  color: type == 'votes'
                      ? Colors.green[600]
                      : Colors.orange[600],
                  size: 20,
                ),
                SizedBox(height: 4),
                Text(
                  type == 'votes' ? '${idea.votes}' : '${idea.aiRating}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: type == 'votes'
                        ? Colors.green[700]
                        : Colors.orange[700],
                  ),
                ),
                if (type == 'rating')
                  Text(
                    '/100',
                    style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getRankColor() {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey[400]!;
      case 3:
        return Colors.brown[400]!;
      default:
        return Colors.purple;
    }
  }

  List<Color> _getRankGradient() {
    switch (rank) {
      case 1:
        return [Colors.amber, Colors.orange];
      case 2:
        return [Colors.grey[300]!, Colors.grey[500]!];
      case 3:
        return [Colors.brown[300]!, Colors.brown[500]!];
      default:
        return [Colors.purple[300]!, Colors.purple[600]!];
    }
  }

  String _getRankEmoji() {
    switch (rank) {
      case 1:
        return '🥇';
      case 2:
        return '🥈';
      case 3:
        return '🥉';
      default:
        return '';
    }
  }
}

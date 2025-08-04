import 'package:flutter/material.dart';
import 'package:pgagi_assignment/models/startup_idea.dart';
import 'package:pgagi_assignment/widgets/action_button.dart';

class IdeaCard extends StatefulWidget {
  final StartupIdea idea;
  final Function(StartupIdea) onVote;
  final Function(StartupIdea) onShare;
  final bool isDarkMode;

  const IdeaCard({
    Key? key,
    required this.idea,
    required this.onVote,
    required this.onShare,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  _IdeaCardState createState() => _IdeaCardState();
}

class _IdeaCardState extends State<IdeaCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: widget.isDarkMode ? Colors.black26 : Colors.black12,
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.idea.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        widget.idea.tagline,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _getRatingGradient(widget.idea.aiRating),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.psychology, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '${widget.idea.aiRating}/100',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Description
            AnimatedCrossFade(
              duration: Duration(milliseconds: 300),
              crossFadeState: _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: Text(
                widget.idea.description.length > 100
                    ? '${widget.idea.description.substring(0, 100)}...'
                    : widget.idea.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                  height: 1.4,
                ),
              ),
              secondChild: Text(
                widget.idea.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                  height: 1.4,
                ),
              ),
            ),

            if (widget.idea.description.length > 100)
              GestureDetector(
                onTap: () => setState(() => _isExpanded = !_isExpanded),
                child: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    _isExpanded ? 'Show less' : 'Read more',
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

            SizedBox(height: 20),

            // Actions
            Row(
              children: [
                Text(
                  _formatDate(widget.idea.createdAt),
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
                Spacer(),
                ActionButton(
                  icon: Icons.share,
                  label: 'Share',
                  color: Colors.blue,
                  onTap: () => widget.onShare(widget.idea),
                ),
                SizedBox(width: 12),
                ActionButton(
                  icon: Icons.thumb_up,
                  label: '${widget.idea.votes}',
                  color: Colors.green,
                  onTap: () => widget.onVote(widget.idea),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  List<Color> _getRatingGradient(int rating) {
    if (rating >= 90) return [Colors.green, Colors.lightGreen];
    if (rating >= 80) return [Colors.blue, Colors.lightBlue];
    if (rating >= 70) return [Colors.orange, Colors.orangeAccent];
    return [Colors.red, Colors.redAccent];
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inMinutes}m ago';
    }
  }
}

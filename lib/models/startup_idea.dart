
class StartupIdea {
  final String id;
  final String name;
  final String tagline;
  final String description;
  final int aiRating;
  int votes;
  final DateTime createdAt;
  List<String> votedUsers;

  StartupIdea({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.aiRating,
    this.votes = 0,
    required this.createdAt,
    List<String>? votedUsers,
  }) : votedUsers = votedUsers ?? [];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'description': description,
      'aiRating': aiRating,
      'votes': votes,
      'createdAt': createdAt.toIso8601String(),
      'votedUsers': votedUsers,
    };
  }

  static StartupIdea fromJson(Map<String, dynamic> json) {
    return StartupIdea(
      id: json['id'],
      name: json['name'],
      tagline: json['tagline'],
      description: json['description'],
      aiRating: json['aiRating'],
      votes: json['votes'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      votedUsers: List<String>.from(json['votedUsers'] ?? []),
    );
  }
}

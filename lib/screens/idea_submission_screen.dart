import 'package:flutter/material.dart';
import 'dart:math';
import 'package:pgagi_assignment/models/startup_idea.dart';
import 'package:pgagi_assignment/screens/main_screen.dart';
import 'package:pgagi_assignment/widgets/text_field.dart';

class IdeaSubmissionScreen extends StatefulWidget {
  final Function(StartupIdea) onSubmit;

  const IdeaSubmissionScreen({super.key, required this.onSubmit});
  @override
  State<StatefulWidget> createState() => _IdeaSubmissionScreenState();
}

class _IdeaSubmissionScreenState extends State<IdeaSubmissionScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _taglineController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isSubmitting = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _taglineController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _showToast(String message, {bool isSuccess = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.error,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: Duration(seconds: 2),
      ),
    );
  }

  int _generateAIRating() {
    final random = Random();
    return 60 + random.nextInt(41); // 60-100 range
  }

  Future<void> _submitIdea() async {
    if (_formKey.currentState!.validate()) {
      _animationController.forward();
      setState(() {
        _isSubmitting = true;
      });

      // Simulate AI processing
      await Future.delayed(Duration(seconds: 2));

      final idea = StartupIdea(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        tagline: _taglineController.text.trim(),
        description: _descriptionController.text.trim(),
        aiRating: _generateAIRating(),
        createdAt: DateTime.now(),
      );

      widget.onSubmit(idea);

      setState(() {
        _isSubmitting = false;
      });
      _animationController.reverse();

      // Clear form
      _nameController.clear();
      _taglineController.clear();
      _descriptionController.clear();

      _showToast(
        '🎉 Idea submitted successfully! AI Rating: ${idea.aiRating}/100',
      );

      // Navigate to Ideas tab
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MainScreen(
            isDarkMode: Theme.of(context).brightness == Brightness.dark,
            toggleTheme: () {},
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '💡 Submit Your Idea',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey[300]),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple, Colors.purpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.3),
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(Icons.rocket_launch, color: Colors.white, size: 40),
                    SizedBox(height: 12),
                    Text(
                      'Turn Your Vision Into Reality',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Share your startup idea and get instant AI feedback',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              // Form Fields
              CustomTextField(
                controller: _nameController,
                label: 'Startup Name',
                hint: 'e.g., EcoRide, FoodieBot, StudyBuddy',
                icon: Icons.business,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your startup name';
                  }
                  if (value.trim().length < 2) {
                    return 'Name must be at least 2 characters';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              CustomTextField(
                controller: _taglineController,
                label: 'Tagline',
                hint: 'e.g., "Sustainable transport for everyone"',
                icon: Icons.campaign,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a tagline';
                  }
                  if (value.trim().length < 5) {
                    return 'Tagline must be at least 5 characters';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              CustomTextField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Describe your idea, target market, key features...',
                icon: Icons.description,
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a description';
                  }
                  if (value.trim().length < 20) {
                    return 'Description must be at least 20 characters';
                  }
                  return null;
                },
              ),

              SizedBox(height: 40),

              // Submit Button
              AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _isSubmitting ? null : _submitIdea,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 8,
                          shadowColor: Colors.purple.withOpacity(0.4),
                        ),
                        child: _isSubmitting
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    'AI is analyzing...',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.psychology,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'Get AI Feedback',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

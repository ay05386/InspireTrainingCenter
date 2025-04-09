import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/my_drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A2151), // Dark blue
              Color(0xFF0D1333), // Darker blue
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.menu, color: Colors.white),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Dashboard',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.notifications_none, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              // Inspire Image Placeholder
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF2A355A),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.1), width: 1),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Inspire',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Image Placeholder',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Grid of Feature Icons
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildFeatureCard(
                        icon: Icons.people_outline,
                        title: 'COMMUNITY',
                        context: context,
                      ),
                      _buildFeatureCard(
                        icon: Icons.assignment_outlined,
                        title: 'MOCK EXAMS',
                        context: context,
                      ),
                      _buildFeatureCard(
                        icon: Icons.question_answer_outlined,
                        title: 'QUIZZES',
                        context: context,
                      ),
                      _buildFeatureCard(
                        icon: Icons.check_circle_outline,
                        title: 'PRACTICES',
                        context: context,
                      ),
                      _buildFeatureCard(
                        icon: Icons.play_circle_outline,
                        title: 'VIDEO',
                        context: context,
                      ),
                      _buildFeatureCard(
                        icon: Icons.download_outlined,
                        title: 'HANDOUT',
                        context: context,
                      ),
                      _buildFeatureCard(
                        icon: Icons.book_outlined,
                        title: 'MANUAL',
                        context: context,
                      ),
                      _buildFeatureCard(
                        icon: Icons.insert_chart_outlined,
                        title: 'PRESENTATION',
                        context: context,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required BuildContext context,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 36,
            color: Colors.white,
          ),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}













/*


    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      drawer: const MyDrawer(),
      body: const Center(
        child: Text(
          'Welcome to Home Screen!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );*/
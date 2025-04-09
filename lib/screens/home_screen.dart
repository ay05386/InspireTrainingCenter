import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/my_drawer.dart';
import '../widgets/app_header.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final List<Animation<double>> _iconAnimations = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Create staggered animations for each icon
    for (int i = 0; i < 8; i++) {
      final begin = 0.1 * i;
      _iconAnimations.add(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            begin,
            begin + 0.5,
            curve: Curves.easeOutBack,
          ),
        ),
      );
    }

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MyDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF345467), // Dark blue
              Color(0xFFBCBCC3), // Darker blue
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Header
              AppHeader(
                title: 'Dashboard',
                onMenuPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),

              // Inspire Image Placeholder
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A355A),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.1), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Inspire',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
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
                      _buildAnimatedFeatureCard(
                        animation: _iconAnimations[0],
                        icon: Icons.people_outline,
                        title: 'COMMUNITY',
                      ),
                      _buildAnimatedFeatureCard(
                        animation: _iconAnimations[1],
                        icon: Icons.assignment_outlined,
                        title: 'MOCK EXAMS',
                      ),
                      _buildAnimatedFeatureCard(
                        animation: _iconAnimations[2],
                        icon: Icons.question_answer_outlined,
                        title: 'QUIZZES',
                      ),
                      _buildAnimatedFeatureCard(
                        animation: _iconAnimations[3],
                        icon: Icons.check_circle_outline,
                        title: 'PRACTICES',
                      ),
                      _buildAnimatedFeatureCard(
                        animation: _iconAnimations[4],
                        icon: Icons.play_circle_outline,
                        title: 'VIDEO',
                      ),
                      _buildAnimatedFeatureCard(
                        animation: _iconAnimations[5],
                        icon: Icons.download_outlined,
                        title: 'HANDOUT',
                      ),
                      _buildAnimatedFeatureCard(
                        animation: _iconAnimations[6],
                        icon: Icons.book_outlined,
                        title: 'MANUAL',
                      ),
                      _buildAnimatedFeatureCard(
                        animation: _iconAnimations[7],
                        icon: Icons.insert_chart_outlined,
                        title: 'PRESENTATION',
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

  Widget _buildAnimatedFeatureCard({
    required Animation<double> animation,
    required IconData icon,
    required String title,
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.scale(
          scale: animation.value,
          child: Opacity(
            opacity: animation.value,
            child: _buildFeatureCard(icon: icon, title: title),
          ),
        );
      },
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
  }) {
    return GestureDetector(
      onTap: () {
        // Handle navigation
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 36,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

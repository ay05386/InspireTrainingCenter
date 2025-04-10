/*import 'package:flutter/material.dart';
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
              Color(0xFF345467),
              Color(0xFFBCBCC3),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppHeader(
                title: 'Dashboard',
                onMenuPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),

              // Updated Logo Container
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Container(
                  height: 100, // Reduced height
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'images/inspire.png', // or use 'inspire logo.png' if that's your actual file
                        fit: BoxFit.contain, // Changed from cover to contain
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
              ),

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
}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspire_training_center/screens/mockexams_screen.dart';
import 'package:inspire_training_center/screens/quiz_screen.dart';
import '../widgets/my_drawer.dart';
import '../widgets/app_header.dart';

// Import screens for navigation
import 'community_screen.dart';

import 'practices_screen.dart';
import 'video_screen.dart';
import 'handout_screen.dart';
import 'manual_screen.dart';
import 'presentation_screen.dart';

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

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Navigation function for grid items
  void _navigateToScreen(int index) {
    Widget destinationScreen;

    switch (index) {
      case 0:
        destinationScreen = const CommunityScreen();
        break;
      case 1:
        destinationScreen = const MockExamsScreen();
        break;
      case 2:
        destinationScreen = const QuizzesScreen();
        break;
      case 3:
        destinationScreen = const PracticesScreen();
        break;
      case 4:
        destinationScreen = const VideoScreen();
        break;
      case 5:
        destinationScreen = const HandoutScreen();
        break;
      case 6:
        destinationScreen = const ManualScreen();
        break;
      case 7:
        destinationScreen = const PresentationScreen();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destinationScreen),
    );
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
              Color(0xFF345467),
              Color(0xFFBCBCC3),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppHeader(
                title: 'Dashboard',
                onMenuPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),

              // Updated Logo Container
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Container(
                  height: 100, // Reduced height
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'images/inspire.png', // or use 'inspire logo.png' if that's your actual file
                        fit: BoxFit.contain, // Changed from cover to contain
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
              ),

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
                        index: 0,
                      ),
                      _buildAnimatedFeatureCard(
                        animation: _iconAnimations[1],
                        icon: Icons.assignment_outlined,
                        title: 'MOCK EXAMS',
                        index: 1,
                      ),
                      _buildAnimatedFeatureCard(
                        animation: _iconAnimations[2],
                        icon: Icons.question_answer_outlined,
                        title: 'QUIZZES',
                        index: 2,
                      ),
                      _buildAnimatedFeatureCard(
                        animation: _iconAnimations[3],
                        icon: Icons.check_circle_outline,
                        title: 'PRACTICES',
                        index: 3,
                      ),
                      _buildAnimatedFeatureCard(
                        animation: _iconAnimations[4],
                        icon: Icons.play_circle_outline,
                        title: 'VIDEO',
                        index: 4,
                      ),
                      _buildAnimatedFeatureCard(
                        animation: _iconAnimations[5],
                        icon: Icons.download_outlined,
                        title: 'HANDOUT',
                        index: 5,
                      ),
                      _buildAnimatedFeatureCard(
                        animation: _iconAnimations[6],
                        icon: Icons.book_outlined,
                        title: 'MANUAL',
                        index: 6,
                      ),
                      _buildAnimatedFeatureCard(
                        animation: _iconAnimations[7],
                        icon: Icons.insert_chart_outlined,
                        title: 'PRESENTATION',
                        index: 7,
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
    required int index,
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.scale(
          scale: animation.value,
          child: Opacity(
            opacity: animation.value,
            child: _buildFeatureCard(
              icon: icon,
              title: title,
              index: index,
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigate to the appropriate screen
        _navigateToScreen(index);
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

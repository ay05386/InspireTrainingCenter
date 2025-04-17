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

    // Fixed animation intervals to ensure they stay within 0.0-1.0 range
    for (int i = 0; i < 8; i++) {
      final begin = 0.1 * i;
      final end = begin + 0.5 > 1.0 ? 1.0 : begin + 0.5;
      _iconAnimations.add(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            begin,
            end,
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
                    color: Color.fromARGB(255, 84, 98, 146),
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
                        'images/inspire.png',
                        fit: BoxFit.contain,
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
                        imageName: 'community.png',
                        title: 'COMMUNITY',
                        index: 0,
                      ),
                      _buildAnimatedFeatureCard(
                        animation: _iconAnimations[1],
                        imageName: 'mockexams.png',
                        title: 'MOCK EXAMS',
                        index: 1,
                      ),
                      _buildAnimatedFeatureCard(
                        animation: _iconAnimations[2],
                        imageName: 'quizzes.png',
                        title: 'QUIZZES',
                        index: 2,
                      ),
                      _buildAnimatedFeatureCard(
                        animation: _iconAnimations[3],
                        imageName: 'practices.png',
                        title: 'PRACTICES',
                        index: 3,
                      ),
                      _buildAnimatedFeatureCard(
                        animation: _iconAnimations[4],
                        imageName: 'video.png',
                        title: 'VIDEO',
                        index: 4,
                      ),
                      _buildAnimatedFeatureCard(
                        animation: _iconAnimations[5],
                        imageName: 'handout.png',
                        title: 'HANDOUT',
                        index: 5,
                      ),
                      _buildAnimatedFeatureCard(
                        animation: _iconAnimations[6],
                        imageName: 'manual.png',
                        title: 'MANUAL',
                        index: 6,
                      ),
                      _buildAnimatedFeatureCard(
                        animation: _iconAnimations[7],
                        imageName: 'presentation.png',
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
    required String imageName,
    required String title,
    required int index,
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        // Ensure animation value is within bounds
        final safeValue = animation.value.clamp(0.0, 1.0);
        return Transform.scale(
          scale: safeValue,
          child: Opacity(
            opacity: safeValue,
            child: _buildFeatureCard(
              imageName: imageName,
              title: title,
              index: index,
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeatureCard({
    required String imageName,
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
            SizedBox(
              width: 110,
              height: 110,
              child: Image.asset(
                'images/$imageName',
                fit: BoxFit.contain,
              ),
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

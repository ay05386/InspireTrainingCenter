import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import all screens
import 'screens/home_screen.dart';
import 'screens/profilescreen.dart';
import 'screens/aboutus_screen.dart';
import 'screens/financial_details.dart';
import 'screens/news_screen.dart';
import 'screens/contactus_screen.dart';
import 'screens/mockexams_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/community_screen.dart';
import 'screens/practices_screen.dart';
import 'screens/video_screen.dart';
import 'screens/handout_screen.dart';
import 'screens/manual_screen.dart';
import 'screens/presentation_screen.dart';

void main() {
  // Add this to ensure initializations are complete before app runs
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inspire Training Center',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0D1333),
        primaryColor: const Color(0xFF1A2151),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF1A2151),
          secondary: Colors.blueAccent.shade200,
          surface: Colors.white.withOpacity(0.05),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: const Color(0xFF0D1333),
          scrimColor: Colors.black.withOpacity(0.7),
        ),
        textTheme: const TextTheme(
          displayLarge:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          titleLarge:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      // Define routes for navigation
      initialRoute: '/', // Explicitly set initial route
      routes: {
        '/': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/about': (context) => const AboutUsScreen(),
        '/financial': (context) => const FinancialServicesScreen(),
        '/news': (context) => const NewsEventsScreen(),
        '/contact': (context) => const ContactUsScreen(),
        '/community': (context) => const CommunityScreen(),
        '/mockexams': (context) => const MockExamsScreen(),
        '/quizzes': (context) => const QuizzesScreen(),
        '/practices': (context) => const PracticesScreen(),
        '/video': (context) => const VideoScreen(),
        '/handout': (context) => const HandoutScreen(),
        '/manual': (context) => const ManualScreen(),
        '/presentation': (context) => const PresentationScreen(),
      },
    );
  }
}

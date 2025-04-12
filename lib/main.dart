import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';
import 'screens/profilescreen.dart';
import 'screens/splash_screen.dart';

// Global key to force rebuild of the entire app if needed
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  // Ensure Flutter is properly initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Force clear image cache on startup
  PaintingBinding.instance.imageCache.clear();
  PaintingBinding.instance.imageCache.clearLiveImages();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF345467),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Enhanced error handling
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('Flutter error: ${details.exception}');
    // Force app rebuild on critical errors
    if (details.exception.toString().contains('image') ||
        details.exception.toString().contains('asset')) {
      _rebuildApp();
    }
  };

  // Run the app
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// Force rebuild the entire app
void _rebuildApp() {
  if (navigatorKey.currentState != null) {
    // This will force a complete rebuild of the app
    navigatorKey.currentState!.pushReplacement(
      MaterialPageRoute(builder: (context) => const MyApp()),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // Add navigator key
      title: 'Inspire Training Center',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF345467),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF345467),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF345467),
          primary: const Color(0xFF345467),
          secondary: const Color(0xFFBCBCC3),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF345467),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}

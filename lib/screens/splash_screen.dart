import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  bool _isNavigating = false;
  bool _imageLoaded = false;
  Timer? _navigationTimer;
  final String _imagePath = 'images/inspire.png';

  // Use memory image instead of asset image
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Load image directly from asset bundle
    _loadImageBytes();

    // Set up navigation with fallbacks
    _setupNavigation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Force reload image when dependencies change
    if (!_imageLoaded) {
      _loadImageBytes();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle app lifecycle changes
    if (state == AppLifecycleState.resumed) {
      // Force reload image when app is resumed
      _loadImageBytes();
    }
  }

  Future<void> _loadImageBytes() async {
    try {
      // Clear any existing image cache
      PaintingBinding.instance.imageCache.clear();
      PaintingBinding.instance.imageCache.clearLiveImages();

      // Load image bytes directly from asset bundle
      final ByteData data = await rootBundle.load(_imagePath);
      if (mounted) {
        setState(() {
          _imageBytes = data.buffer.asUint8List();
          _imageLoaded = true;
        });
      }
    } catch (e) {
      debugPrint('Failed to load image bytes: $e');
      // Still mark as loaded to avoid infinite retries
      if (mounted) {
        setState(() {
          _imageLoaded = true;
        });
      }
    }
  }

  void _setupNavigation() {
    // Cancel any existing timer
    _navigationTimer?.cancel();

    // Set up new timer
    _navigationTimer = Timer(const Duration(milliseconds: 2000), () {
      _navigateToHome();
    });

    // Fallback timer in case the first one fails
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted && !_isNavigating) {
        debugPrint('Using fallback navigation');
        _navigateToHome();
      }
    });
  }

  void _navigateToHome() {
    if (!mounted || _isNavigating) return;

    setState(() {
      _isNavigating = true;
    });

    // Use pushAndRemoveUntil to clear navigation history
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo container
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: _imageBytes != null
                          ? Image.memory(
                              _imageBytes!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.contain,
                            )
                          : const Icon(
                              Icons.school,
                              size: 80,
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'INSPIRE TRAINING',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Excellence in Education',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 40),
                // Loading indicator
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withOpacity(0.7),
                    ),
                    strokeWidth: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

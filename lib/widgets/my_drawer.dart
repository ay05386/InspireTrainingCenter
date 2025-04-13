import 'package:flutter/material.dart';
import '../screens/aboutus_screen.dart';
import '../screens/contactus_screen.dart';
import '../screens/financial_details.dart';
import '../screens/home_screen.dart';
import '../screens/news_screen.dart';
import '../screens/profilescreen.dart';
import '../screens/splash_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A2151), Color(0xFF0D1333)],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildHeader(),
            _buildTile(Icons.home, 'Home',
                () => _navigateTo(context, const HomeScreen())),
            _buildTile(Icons.person, 'Profile',
                () => _navigateTo(context, const ProfileScreen())),
            _buildTile(Icons.info, 'About Us',
                () => _navigateTo(context, const AboutUsScreen())),
            _buildTile(Icons.attach_money, 'Financial',
                () => _navigateTo(context, const FinancialDetailsScreen())),
            _buildTile(Icons.event, 'News',
                () => _navigateTo(context, const NewsEventsScreen())),
            _buildTile(Icons.contact_mail, 'Contact Us',
                () => _navigateTo(context, const ContactUsScreen())),
            const Divider(color: Colors.white54, height: 20),
            _buildTile(
                Icons.logout, 'Log Out', () => _showLogoutDialog(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2A355A),
            const Color(0xFF1A2151).withOpacity(0.8)
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.1),
            ),
            child: const Icon(Icons.person, size: 40, color: Colors.white),
          ),
          const SizedBox(height: 12),
          const Text(
            'Inspire Training',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.pop(context); // Close the drawer first

    // Use pushReplacement to replace the current screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A2151),
        title: const Text('Log Out', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Are you sure you want to log out?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SplashScreen()),
                (route) => false,
              );
            },
            child: const Text('Log Out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

// Import your screen files
import '../screens/home_screen.dart';
import '../screens/profilescreen.dart';
import '../screens/aboutus_screen.dart';
import '../screens/financial_details.dart';
import '../screens/news_screen.dart';
import '../screens/contactus_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A2151), // Dark blue
              Color(0xFF0D1333), // Darker blue
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF2A355A),
                    const Color(0xFF1A2151).withOpacity(0.8),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
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
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Inspire Training',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            _buildAnimatedListTile(
              icon: Icons.home,
              title: 'Home',
              index: 0,
              onTap: () {
                Navigator.pop(context);
                // Using pushReplacement to replace current screen with HomeScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            _buildAnimatedListTile(
              icon: Icons.person,
              title: 'My Profile',
              index: 1,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
              },
            ),
            _buildAnimatedListTile(
              icon: Icons.info,
              title: 'About Us',
              index: 2,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AboutUsScreen()),
                );
              },
            ),
            _buildAnimatedListTile(
              icon: Icons.attach_money,
              title: 'Financial Services',
              index: 3,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FinancialServicesScreen()),
                );
              },
            ),
            _buildAnimatedListTile(
              icon: Icons.event,
              title: 'News and Events',
              index: 4,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NewsEventsScreen()),
                );
              },
            ),
            _buildAnimatedListTile(
              icon: Icons.contact_mail,
              title: 'Contact Us',
              index: 5,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ContactUsScreen()),
                );
              },
            ),
            Divider(color: Colors.white.withOpacity(0.2)),
            _buildAnimatedListTile(
              icon: Icons.logout,
              title: 'Log Out',
              index: 6,
              onTap: () {
                Navigator.pop(context);
                // Show dialog to confirm logout
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: const Color(0xFF1A2151),
                      title: const Text(
                        'Log Out',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: const Text(
                        'Are you sure you want to log out?',
                        style: TextStyle(color: Colors.white70),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close dialog
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close dialog
                            // Add actual logout logic here
                            // For example, clear user session and navigate to login screen
                            // For demonstration, we'll just go back to home
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                            );
                          },
                          child: const Text(
                            'Log Out',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedListTile({
    required IconData icon,
    required String title,
    required int index,
    required VoidCallback onTap,
  }) {
    // Using a safer approach for animation values
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 100)),
      builder: (context, value, child) {
        // Ensure value is within bounds
        final safeValue = value.clamp(0.0, 1.0);
        return Transform.translate(
          offset: Offset(20 * (1 - safeValue), 0),
          child: Opacity(
            opacity: safeValue,
            child: child,
          ),
        );
      },
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: onTap,
        hoverColor: Colors.white.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

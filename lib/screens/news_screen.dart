import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/my_drawer.dart';
import '../widgets/app_header.dart';

class NewsEventsScreen extends ConsumerStatefulWidget {
  const NewsEventsScreen({super.key});

  @override
  ConsumerState<NewsEventsScreen> createState() => _NewsEventsScreenState();
}

class _NewsEventsScreenState extends ConsumerState<NewsEventsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showEvents = true; // Toggle between news and events

  // Mock data
  final List<Map<String, dynamic>> _newsItems = [
    {
      'title': 'New Courses Available',
      'date': '2025-04-08',
      'image': 'images/course.jpg',
      'description':
          'Five new specialized courses have been added to our catalog. Explore the latest in machine learning and cloud computing.'
    },
    {
      'title': 'Mobile App Update',
      'date': '2025-04-05',
      'image': 'images/update.jpg',
      'description':
          'Our latest app update introduces offline video playback and improved PDF annotations. Update now!'
    },
    {
      'title': 'Scholarship Applications Open',
      'date': '2025-04-01',
      'image': 'images/scholarship.jpg',
      'description':
          'Apply now for our summer scholarship program. Limited spots available for qualified students.'
    },
    {
      'title': 'New Instructor Joined',
      'date': '2025-03-28',
      'image': 'images/instructor.jpg',
      'description':
          'We welcome Dr. Ahmed Hassan to our team of instructors. Dr. Hassan specializes in cybersecurity and will be leading advanced security courses.'
    },
  ];

  final List<Map<String, dynamic>> _eventItems = [
    {
      'title': 'Flutter Workshop',
      'date': '2025-04-15',
      'time': '10:00 AM - 2:00 PM',
      'location': 'Inspire Training Center, Hall A',
      'image': 'images/workshop.jpg',
    },
    {
      'title': 'Career Fair 2025',
      'date': '2025-04-20',
      'time': '9:00 AM - 5:00 PM',
      'location': 'City Convention Center',
      'image': 'images/career.jpg',
    },
    {
      'title': 'Mobile Development Hackathon',
      'date': '2025-05-01',
      'time': '9:00 AM - 9:00 PM',
      'location': 'Inspire Innovation Lab',
      'image': 'images/hackathon.jpg',
    },
    {
      'title': 'Graduation Ceremony',
      'date': '2025-05-15',
      'time': '6:00 PM - 9:00 PM',
      'location': 'Royal Conference Hall',
      'image': 'images/graduation.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
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
                title: 'News & Events',
                onMenuPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),

              // Toggle buttons for News/Events
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _showEvents = false),
                          child: Container(
                            decoration: BoxDecoration(
                              color: !_showEvents
                                  ? Colors.white.withOpacity(0.2)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                'NEWS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: !_showEvents
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _showEvents = true),
                          child: Container(
                            decoration: BoxDecoration(
                              color: _showEvents
                                  ? Colors.white.withOpacity(0.2)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                'EVENTS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: _showEvents
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content area
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _showEvents ? _buildEventsList() : _buildNewsList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsList() {
    return ListView.builder(
      key: const ValueKey<String>('newsList'),
      padding: const EdgeInsets.all(16.0),
      itemCount: _newsItems.length,
      itemBuilder: (context, index) {
        final news = _newsItems[index];

        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            final delay = index * 0.2;
            final start = delay;
            final end = start + 0.6 > 1.0 ? 1.0 : start + 0.6;

            final animation = CurvedAnimation(
              parent: _animationController,
              curve: Interval(start, end, curve: Curves.easeOut),
            );

            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.2),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      color: Colors.grey[800],
                      child: Center(
                        child: Icon(
                          _getIconForNewsType(news['title']),
                          size: 48,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDate(news['date']),
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 12,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'NEWS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        news['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        news['description'],
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Handle read more action
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Read More',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEventsList() {
    return ListView.builder(
      key: const ValueKey<String>('eventsList'),
      padding: const EdgeInsets.all(16.0),
      itemCount: _eventItems.length,
      itemBuilder: (context, index) {
        final event = _eventItems[index];

        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            final delay = index * 0.2;
            final start = delay;
            final end = start + 0.6 > 1.0 ? 1.0 : start + 0.6;

            final animation = CurvedAnimation(
              parent: _animationController,
              curve: Interval(start, end, curve: Curves.easeOut),
            );

            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.2),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      color: Colors.grey[800],
                      child: Center(
                        child: Icon(
                          _getIconForEventType(event['title']),
                          size: 48,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                size: 14,
                                color: Colors.white70,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _formatDate(event['date']),
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'EVENT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            event['time'],
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              event['location'],
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Handle register action
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFF2A355A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              // Handle details action
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Details',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper methods
  String _formatDate(String dateStr) {
    final date = DateTime.parse(dateStr);
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  IconData _getIconForNewsType(String title) {
    if (title.contains('Course')) return Icons.school;
    if (title.contains('Update')) return Icons.system_update;
    if (title.contains('Scholarship')) return Icons.monetization_on;
    if (title.contains('Instructor')) return Icons.person;
    return Icons.article;
  }

  IconData _getIconForEventType(String title) {
    if (title.contains('Workshop')) return Icons.handyman;
    if (title.contains('Career')) return Icons.work;
    if (title.contains('Hackathon')) return Icons.code;
    if (title.contains('Graduation')) return Icons.school;
    return Icons.event;
  }
}

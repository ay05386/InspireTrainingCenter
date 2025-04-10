import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FinancialDetailsScreen(),
    );
  }
}

class FinancialDetailsScreen extends ConsumerStatefulWidget {
  const FinancialDetailsScreen({super.key});

  @override
  ConsumerState<FinancialDetailsScreen> createState() =>
      _FinancialDetailsScreenState();
}

class _FinancialDetailsScreenState
    extends ConsumerState<FinancialDetailsScreen> {
  int _selectedTab = 0;
  int _selectedCourseIndex = 0;
  bool _isExpanded = false;

  static const List<String> monthAbbreviations = [
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

  static const List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  final List<Map<String, dynamic>> _courses = [
    {
      'id': 'CRS-2305',
      'name': 'Advanced Flutter Development',
      'image': 'assets/flutter_course.jpg',
      'totalAmount': 750.0,
      'paidAmount': 350.0,
      'remainingAmount': 400.0,
      'nextPaymentDate': DateTime(2025, 4, 15),
      'installments': [
        {
          'date': DateTime(2025, 2, 10),
          'amount': 200.0,
          'status': 'Paid',
          'method': 'Credit Card',
          'reference': 'TXN48729'
        },
        {
          'date': DateTime(2025, 3, 15),
          'amount': 150.0,
          'status': 'Paid',
          'method': 'Online Banking',
          'reference': 'TXN52631'
        },
        {
          'date': DateTime(2025, 4, 15),
          'amount': 200.0,
          'status': 'Upcoming',
          'method': 'Pending',
          'reference': 'N/A'
        },
        {
          'date': DateTime(2025, 5, 15),
          'amount': 200.0,
          'status': 'Pending',
          'method': 'Pending',
          'reference': 'N/A'
        },
      ]
    },
    {
      'id': 'CRS-2169',
      'name': 'Firebase & Cloud Solutions',
      'image': 'assets/firebase_course.jpg',
      'totalAmount': 500.0,
      'paidAmount': 250.0,
      'remainingAmount': 250.0,
      'nextPaymentDate': DateTime(2025, 4, 20),
      'installments': [
        {
          'date': DateTime(2025, 2, 20),
          'amount': 125.0,
          'status': 'Paid',
          'method': 'Credit Card',
          'reference': 'TXN49015'
        },
        {
          'date': DateTime(2025, 3, 20),
          'amount': 125.0,
          'status': 'Paid',
          'method': 'Online Banking',
          'reference': 'TXN53478'
        },
        {
          'date': DateTime(2025, 4, 20),
          'amount': 125.0,
          'status': 'Upcoming',
          'method': 'Pending',
          'reference': 'N/A'
        },
        {
          'date': DateTime(2025, 5, 20),
          'amount': 125.0,
          'status': 'Pending',
          'method': 'Pending',
          'reference': 'N/A'
        },
      ]
    },
    {
      'id': 'CRS-2241',
      'name': 'UI/UX Design Masterclass',
      'image': 'assets/uiux_course.jpg',
      'totalAmount': 600.0,
      'paidAmount': 200.0,
      'remainingAmount': 400.0,
      'nextPaymentDate': DateTime(2025, 5, 5),
      'installments': [
        {
          'date': DateTime(2025, 3, 5),
          'amount': 200.0,
          'status': 'Paid',
          'method': 'Credit Card',
          'reference': 'TXN51239'
        },
        {
          'date': DateTime(2025, 5, 5),
          'amount': 200.0,
          'status': 'Upcoming',
          'method': 'Pending',
          'reference': 'N/A'
        },
        {
          'date': DateTime(2025, 7, 5),
          'amount': 200.0,
          'status': 'Pending',
          'method': 'Pending',
          'reference': 'N/A'
        },
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  double _calculateTotalBalance() {
    return _courses.fold(0.0, (sum, course) => sum + course['remainingAmount']);
  }

  int _calculateDaysLeft(DateTime date) {
    return date.difference(DateTime.now()).inDays;
  }

  IconData _getCourseIcon(String courseName) {
    final name = courseName.toLowerCase();
    if (name.contains('flutter')) {
      return Icons.developer_mode;
    } else if (name.contains('firebase')) {
      return Icons.cloud;
    } else if (name.contains('ui/ux') || name.contains('design')) {
      return Icons.design_services;
    }
    return Icons.book;
  }

  String _formatDateMMMYYYY(DateTime date) {
    return '${monthAbbreviations[date.month - 1]} ${date.year}';
  }

  String _formatDateDDMMMYYYY(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    return '$day ${monthAbbreviations[date.month - 1]} ${date.year}';
  }

  String _formatDateDDMMMMYYYY(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    return '$day ${monthNames[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final selectedCourse = _courses[_selectedCourseIndex];
    final screenHeight = MediaQuery.of(context).size.height;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF151C2B),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Financial Details',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              letterSpacing: 0.5,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: screenHeight * 0.22,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF3A6AF5),
                    const Color(0xFF295BE0),
                    const Color(0xFF1E44C2).withOpacity(0.9),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 90, 20, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Total Balance',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'KWD ${_calculateTotalBalance().toStringAsFixed(1)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_rounded,
                              color: Colors.white70,
                              size: 14,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _formatDateMMMYYYY(DateTime.now()),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFF1D2636),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  _buildTabButton('Courses', 0),
                  _buildTabButton('Payments', 1),
                  _buildTabButton('Upcoming', 2),
                ],
              ),
            ),
            Expanded(
              child: _selectedTab == 0
                  ? _buildCoursesTab()
                  : (_selectedTab == 1
                      ? _buildPaymentsTab()
                      : _buildUpcomingTab()),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFF1D2636),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavBarItem(Icons.home_rounded, 'Home', false),
              _buildNavBarItem(
                  Icons.account_balance_wallet_rounded, 'Finance', true),
              _buildNavBarItem(Icons.school_rounded, 'Courses', false),
              _buildNavBarItem(Icons.person_rounded, 'Profile', false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = _selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF3A6AF5) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white60,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavBarItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xFF3A6AF5) : Colors.white60,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF3A6AF5) : Colors.white60,
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildCoursesTab() {
    final selectedCourse = _courses[_selectedCourseIndex];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Your Courses',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '${_courses.length} Active',
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: _courses.length,
              itemBuilder: (context, index) {
                final course = _courses[index];
                final isSelected = index == _selectedCourseIndex;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCourseIndex = index;
                    });
                  },
                  child: Container(
                    width: 140,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF3A6AF5),
                                const Color(0xFF295BE0),
                              ],
                            )
                          : LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF2A3546),
                                const Color(0xFF212936),
                              ],
                            ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: const Color(0xFF3A6AF5).withOpacity(0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              )
                            ]
                          : [],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _getCourseIcon(course['name']),
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              course['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'KWD ${course['totalAmount'].toStringAsFixed(1)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'ID: ${course['id']}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Course Details',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1D2636),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildPaymentStat(
                        'Paid',
                        selectedCourse['paidAmount'],
                        const Color(0xFF4CD080),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 1,
                      color: Colors.white.withOpacity(0.1),
                    ),
                    Expanded(
                      child: _buildPaymentStat(
                        'Remaining',
                        selectedCourse['remainingAmount'],
                        const Color(0xFFFFA74F),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Payment Progress',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${((selectedCourse['paidAmount'] / selectedCourse['totalAmount']) * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Stack(
                        children: [
                          Container(
                            height: 8,
                            width: double.infinity,
                            color: Colors.white.withOpacity(0.1),
                          ),
                          FractionallySizedBox(
                            widthFactor: selectedCourse['paidAmount'] /
                                selectedCourse['totalAmount'],
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF4CD080),
                                    const Color(0xFF4CD080).withOpacity(0.8),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_rounded,
                              color: Colors.white70,
                              size: 14,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Next Payment: ${_formatDateDDMMMYYYY(selectedCourse['nextPaymentDate'])}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'KWD ${selectedCourse['installments'].firstWhere((i) => i['status'] == 'Upcoming')['amount'].toStringAsFixed(1)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1D2636),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Payment Schedule',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: Text(
                        _isExpanded ? 'Show Less' : 'Show All',
                        style: const TextStyle(
                          color: Color(0xFF3A6AF5),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ..._buildPaymentScheduleItems(
                    selectedCourse['installments'], _isExpanded),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPaymentScheduleItems(
      List<dynamic> installments, bool showAll) {
    final items = showAll ? installments : installments.take(2).toList();

    return items.map((installment) {
      final bool isPaid = installment['status'] == 'Paid';
      final bool isUpcoming = installment['status'] == 'Upcoming';

      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isPaid
                ? const Color(0xFF4CD080).withOpacity(0.3)
                : isUpcoming
                    ? const Color(0xFFFFA74F).withOpacity(0.3)
                    : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (isPaid
                        ? const Color(0xFF4CD080)
                        : isUpcoming
                            ? const Color(0xFFFFA74F)
                            : Colors.grey)
                    .withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isPaid
                    ? Icons.check_rounded
                    : isUpcoming
                        ? Icons.access_time_rounded
                        : Icons.schedule_rounded,
                color: isPaid
                    ? const Color(0xFF4CD080)
                    : isUpcoming
                        ? const Color(0xFFFFA74F)
                        : Colors.grey,
                size: 16,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatDateDDMMMMYYYY(installment['date']),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isPaid
                        ? 'Paid via ${installment['method']}'
                        : isUpcoming
                            ? 'Due in ${_calculateDaysLeft(installment['date'])} days'
                            : 'Pending payment',
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'KWD ${installment['amount'].toStringAsFixed(1)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  installment['status'],
                  style: TextStyle(
                    color: isPaid
                        ? const Color(0xFF4CD080)
                        : isUpcoming
                            ? const Color(0xFFFFA74F)
                            : Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildPaymentStat(String title, double amount, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'KWD ${amount.toStringAsFixed(1)}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            title == 'Paid' ? 'Complete' : 'Pending',
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentsTab() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Payments',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.filter_list_rounded,
                      color: Colors.white60,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Filter',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._buildAllPayments(),
        ],
      ),
    );
  }

  List<Widget> _buildAllPayments() {
    List<Map<String, dynamic>> allPayments = [];

    for (var course in _courses) {
      for (var installment in course['installments']) {
        if (installment['status'] == 'Paid') {
          allPayments.add({
            ...installment,
            'courseName': course['name'],
            'courseId': course['id'],
          });
        }
      }
    }

    allPayments.sort((a, b) => b['date'].compareTo(a['date']));

    return allPayments.map((payment) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1D2636),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF4CD080).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_outline_rounded,
                color: Color(0xFF4CD080),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    payment['courseName'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDateDDMMMYYYY(payment['date']),
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'KWD ${payment['amount'].toStringAsFixed(1)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildUpcomingTab() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Upcoming Payments',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Pay All',
                  style: TextStyle(
                    color: Color(0xFF3A6AF5),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._buildUpcomingPayments(),
        ],
      ),
    );
  }

  List<Widget> _buildUpcomingPayments() {
    List<Map<String, dynamic>> upcomingPayments = [];

    for (var course in _courses) {
      for (var installment in course['installments']) {
        if (installment['status'] == 'Upcoming') {
          upcomingPayments.add({
            ...installment,
            'courseName': course['name'],
          });
        }
      }
    }

    upcomingPayments.sort((a, b) => a['date'].compareTo(b['date']));

    return upcomingPayments.map((payment) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1D2636),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFA74F).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.access_time_rounded,
                color: Color(0xFFFFA74F),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    payment['courseName'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Due in ${_calculateDaysLeft(payment['date'])} days',
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDateDDMMMYYYY(payment['date']),
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'KWD ${payment['amount'].toStringAsFixed(1)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

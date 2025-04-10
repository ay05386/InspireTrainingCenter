import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/app_header.dart';

class FinancialServicesScreen extends ConsumerStatefulWidget {
  const FinancialServicesScreen({super.key});

  @override
  ConsumerState<FinancialServicesScreen> createState() =>
      _FinancialServicesScreenState();
}

class _FinancialServicesScreenState
    extends ConsumerState<FinancialServicesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Demo financial data
  final List<Map<String, dynamic>> _installments = [
    {
      'id': 'INS001',
      'courseName': 'Advanced Flutter Development',
      'totalAmount': 750.0,
      'paid': 350.0,
      'remaining': 400.0,
      'nextPayment': '15 Apr 2025',
      'paymentHistory': [
        {'date': '10 Feb 2025', 'amount': 200.0, 'status': 'Paid'},
        {'date': '15 Mar 2025', 'amount': 150.0, 'status': 'Paid'},
      ]
    },
    {
      'id': 'INS002',
      'courseName': 'Firebase Masterclass',
      'totalAmount': 500.0,
      'paid': 250.0,
      'remaining': 250.0,
      'nextPayment': '20 Apr 2025',
      'paymentHistory': [
        {'date': '20 Feb 2025', 'amount': 125.0, 'status': 'Paid'},
        {'date': '20 Mar 2025', 'amount': 125.0, 'status': 'Paid'},
      ]
    },
    {
      'id': 'INS003',
      'courseName': 'UI/UX Design Principles',
      'totalAmount': 600.0,
      'paid': 200.0,
      'remaining': 400.0,
      'nextPayment': '5 May 2025',
      'paymentHistory': [
        {'date': '5 Mar 2025', 'amount': 200.0, 'status': 'Paid'},
      ]
    }
  ];

  int _selectedInstallmentIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
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
    final selectedInstallment = _installments[_selectedInstallmentIndex];

    return Scaffold(
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
                title: 'Financial Services',
                onMenuPressed: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Summary Card
                          _buildSummaryCard(selectedInstallment),
                          const SizedBox(height: 20),
                          // Course Selection
                          Text(
                            'Your Courses',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 18, letterSpacing: 0.5),
                          ),
                          const SizedBox(height: 12),
                          // Course Scrolling List
                          SizedBox(
                            height: 110,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _installments.length,
                              itemBuilder: (context, index) {
                                return _buildCourseCard(
                                  installment: _installments[index],
                                  isSelected:
                                      index == _selectedInstallmentIndex,
                                  onTap: () {
                                    setState(() {
                                      _selectedInstallmentIndex = index;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Payment History
                          Text(
                            'Payment History',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 18, letterSpacing: 0.5),
                          ),
                          const SizedBox(height: 12),
                          // Payment History List (using shrinkWrap to prevent overflow)
                          _buildPaymentHistory(
                              selectedInstallment['paymentHistory']),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(Map<String, dynamic> installment) {
    final progress = installment['paid'] / installment['totalAmount'];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2A355A),
            Color(0xFF1A2151),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row with course name and ID
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  installment['courseName'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'ID: ${installment['id']}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Amount information row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAmountInfo(
                title: 'Total',
                amount: installment['totalAmount'],
                icon: Icons.account_balance_wallet,
              ),
              _buildAmountInfo(
                title: 'Paid',
                amount: installment['paid'],
                icon: Icons.check_circle,
                color: Colors.green,
              ),
              _buildAmountInfo(
                title: 'Remaining',
                amount: installment['remaining'],
                icon: Icons.timelapse,
                color: Colors.amber,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Payment progress section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Payment Progress',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Stack(
                children: [
                  Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: progress,
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.shade300,
                            Colors.blue.shade600,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${(progress * 100).toStringAsFixed(0)}% Complete',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Next: ${installment['nextPayment']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountInfo({
    required String title,
    required double amount,
    required IconData icon,
    Color color = Colors.white,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 14,
            ),
            const SizedBox(width: 4),
            Text(
              title,
              style: TextStyle(
                color: color.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'KWD ${amount.toStringAsFixed(1)}',
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCourseCard({
    required Map<String, dynamic> installment,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF1A2151)
              : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? Colors.white.withOpacity(0.3)
                : Colors.white.withOpacity(0.1),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF1A2151).withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              installment['courseName'],
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              'Total: KWD ${installment['totalAmount'].toStringAsFixed(1)}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Colors.blue.shade200,
                  size: 12,
                ),
                const SizedBox(width: 4),
                Text(
                  'Next: ${installment['nextPayment']}',
                  style: TextStyle(
                    color: Colors.blue.shade200,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentHistory(List<dynamic> history) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: history.length,
      padding: const EdgeInsets.only(bottom: 8),
      itemBuilder: (context, index) {
        final payment = history[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 18,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      payment['date'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      payment['status'],
                      style: TextStyle(
                        color: payment['status'] == 'Paid'
                            ? Colors.green
                            : Colors.amber,
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
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

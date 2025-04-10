import 'package:flutter/material.dart';

class MockExamsScreen extends StatelessWidget {
  const MockExamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mock Exams'),
        backgroundColor: Color(0xFF345467),
      ),
      body: const Center(
        child: Text(
          'Welcome to Mock Exams!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

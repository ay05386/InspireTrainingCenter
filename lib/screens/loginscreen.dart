import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: const Center(
        child: Text(
          'Welcome to Login Screen!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

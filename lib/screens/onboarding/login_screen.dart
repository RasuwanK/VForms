import 'package:flutter/material.dart';
import 'package:vforms/components/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            color: Color(0xFF4687E1),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Login'),
            Button(
              text: 'Skip For Now',
              onPressed: () {
                Navigator.pushNamed(context, "/onboarding/initialize");
              },
              icon: Icons.arrow_forward,
            )
          ],
        ),
      )
    );
  }
}
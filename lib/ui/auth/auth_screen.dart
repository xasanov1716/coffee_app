import 'package:flutter/material.dart';

import 'pages/login_page.dart';
import 'pages/signup_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoginPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDE0D4),
      body: Stack(children: [
        Column(
          children: [
            Image.asset('assets/images/coffee_ellipse.png'),
            const Spacer(),
          ],
        ),
        isLoginPage
            ? LoginPage(
                onChanged: () {
                  setState(() {
                    isLoginPage = false;
                  });
                },
              )
            : SignUpScreen(
                onChanged: () {
                  setState(() {
                    isLoginPage = true;
                  });
                },
              ),
      ]),
    );
  }
}

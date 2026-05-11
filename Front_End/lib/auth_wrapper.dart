import 'package:flutter/material.dart';
import 'package:front_end/pages/auth_pages/login_page.dart';
// import 'package:front_end/pages/auth_pages/signup_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // body: SignupPage()
        body: LoginPage()
    );
  }
}

import 'package:flutter/material.dart';
import 'package:front_end/pages/profiles/user_profile.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false, body: ProfileSettingsPage());
  }
}

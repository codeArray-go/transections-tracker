import 'package:flutter/material.dart';
import 'package:front_end/auth_wrapper.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'transection-tracker',
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(surface: Color(0xFF191919), primary: Colors.white, secondary: Colors.grey),

        scaffoldBackgroundColor: const Color(0xFF191919),
        textTheme: TextTheme(titleMedium: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
      ),
      home: AuthWrapper(),
    );
  }
}

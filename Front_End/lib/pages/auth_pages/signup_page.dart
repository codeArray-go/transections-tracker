import 'package:flutter/material.dart';
import 'package:front_end/components/input_box.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color fieldBackground = Colors.black;
    final Color cardBackground = const Color(0xFF1A1A1A);

    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            color: cardBackground,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Rupee Icon Container
              Container(
                decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.all(12),
                child: const Icon(Icons.currency_rupee, color: Colors.white, size: 28),
              ),
              const SizedBox(height: 20),

              Text(
                'Create your account',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: -0.5),
              ),
              const SizedBox(height: 8),
              const Text('It will take a few seconds', style: TextStyle(color: Colors.white54, fontSize: 14)),

              const SizedBox(height: 30),

              // Input Grouping
              Column(
                children: [
                  InputBox(textController: fullNameController, labelText: 'Full name', bgColor: fieldBackground, hintText: 'Cobra', icon: const Icon(Icons.person_outline, size: 20)),
                  const SizedBox(height: 10),
                  InputBox(textController: emailController, labelText: 'Email', bgColor: fieldBackground, hintText: 'testgmail123@gmail.com', icon: const Icon(Icons.email_outlined, size: 20)),
                  const SizedBox(height: 10),
                  InputBox(textController: passwordController, labelText: 'Password', bgColor: fieldBackground, hintText: '********', icon: const Icon(Icons.lock_outline, size: 20)),
                  const SizedBox(height: 10),
                  InputBox(textController: confirmPasswordController, labelText: 'Confirm Password', bgColor: fieldBackground, hintText: '********', icon: const Icon(Icons.lock_outline, size: 20)),
                ],
              ),

              const SizedBox(height: 32),

              // Submit Button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text('Submit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),

              const SizedBox(height: 16),

              // Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have account ? ', style: TextStyle(color: Colors.white70)),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Sign in',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

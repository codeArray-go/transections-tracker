import 'package:flutter/material.dart';

class InputBoxEditingPage extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const InputBoxEditingPage({super.key, required this.child, this.padding, this.borderRadius = 16.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF1E1E1E), Color(0xFF121212)]),
        boxShadow: [
          BoxShadow(color: Colors.black, offset: const Offset(6, 6), blurRadius: 12),
          BoxShadow(color: Colors.white.withValues(alpha: 0.04), offset: const Offset(-2, -2), blurRadius: 8),
        ],
        border: Border.all(color: Colors.white.withValues(alpha: 0.02), width: 1),
      ),
      child: child,
    );
  }
}

// --- INPUT FIELD ---
class Custom3DInputField extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final IconData? suffixIcon;
  final Widget? customPrefix;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool isNumber;

  const Custom3DInputField({super.key, required this.hint, this.icon, this.suffixIcon, this.customPrefix, this.controller, this.readOnly = false, this.onTap, this.isNumber = false});

  @override
  Widget build(BuildContext context) {
    return InputBoxEditingPage(
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: isNumber ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
        style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white24),
          prefixIcon: customPrefix ?? (icon != null ? Icon(icon, color: Colors.white38, size: 20) : null),
          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.white38, size: 20) : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}

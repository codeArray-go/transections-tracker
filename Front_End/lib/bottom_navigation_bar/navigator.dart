import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_end/bottom_navigation_bar/helper.dart';

class NavigatorPage extends ConsumerWidget {
  const NavigatorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentGeometry.center,
        children: [Positioned(bottom: 15, child: MainNavigator())],
      ),
    );
  }
}

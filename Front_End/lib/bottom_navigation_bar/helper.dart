import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainNavigator extends ConsumerWidget {
  const MainNavigator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<dynamic> icons = [Icons.home, Icons.settings, Icons.search, Icons.person];

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(color: const Color(0xFF000000), borderRadius: BorderRadius.circular(50)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(icons.length, (index) {
          final item = icons[index];
          return GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 26, vertical: 12),
              decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(30)),
              child: Icon(item, size: 25, color: Colors.white),
            ),
          );
        }),
      ),
    );
  }
}

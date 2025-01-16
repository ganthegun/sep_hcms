import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FloatingButton extends StatelessWidget {
  final String path;

  const FloatingButton({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    switch (path) {
      case '/booking':
        return FloatingActionButton(
          onPressed: () {
            context.go('/booking/create');
          },
          backgroundColor: const Color.fromARGB(255, 232, 244, 212),
          foregroundColor: Colors.black,
          child: const Icon(Icons.add),
        );
    // Add more cases here if you want to use floating button in other pages
      default:
        return Placeholder(
          color: Colors.transparent,
        );
    }
  }
}
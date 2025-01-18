import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserProfileEditSuccess extends StatelessWidget {
  const UserProfileEditSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified,
            size: 80,
            color: const Color.fromARGB(255, 44, 144, 47),
          ),
          SizedBox(height: 10),
          Text(
            'Your profile is successfully updated!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        Center(
          child: SizedBox(
            width: 100,
            child: TextButton(
              onPressed: () {
                context.go('/userProfilePage');
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green.shade100, // Matches the design
                foregroundColor: Colors.black, // Text color for contrast
              ),
              child: const Text('Ok'),
            ),
          ),
        ),
      ],
    );
  }
}

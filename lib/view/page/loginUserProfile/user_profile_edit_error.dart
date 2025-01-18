import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserProfileEditError extends StatelessWidget {
  const UserProfileEditError({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'System message',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 221, 156, 177),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Invalid profile editing! All profile changes have been discarded.',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 17, 0),
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Please ensure that all your profile information is filled in accurately and precisely.',
              style: TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
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

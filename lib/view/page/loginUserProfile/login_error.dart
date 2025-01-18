import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginError extends StatelessWidget {
  const LoginError({super.key});

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
              'Invalid email or password!',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 17, 0),
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Please enter the correct email and password. Kindly contact our customer support at 018-8888888 if you encounter any issure during login',
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
                context.go('/');
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

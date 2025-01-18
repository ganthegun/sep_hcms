import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sep_hcms/view/widget/image_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          children: [
            Image.asset(
              'assets/homepage.png',
              fit: BoxFit.fitWidth,
              width: double.infinity,
              alignment: Alignment.topCenter,
            ),
            const Positioned(
              top: 100,
              left: 20,
              child: Text(
                "Welcome to HCMS,\nUser!",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  foregroundColor: Colors.black,
                ),
                onPressed: () async {
                  await _auth.signOut();
                  context.go('/');
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Logout',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ImageButton(
                title: 'Booking',
                imagePath: 'assets/booking.png',
                callback: () => context.go('/booking'),
              ),
              ImageButton(
                title: 'Schedule',
                imagePath: 'assets/schedule.png',
                callback: () {},
              ),
              ImageButton(
                title: 'Activity\nUpdate',
                imagePath: 'assets/activity_update.png',
                callback: () {},
              ),
              ImageButton(
                title: 'Payment',
                imagePath: 'assets/payment.png',
                callback: () {},
              ),
              ImageButton(
                title: 'Rating',
                imagePath: 'assets/rating.png',
                callback: () {},
              ),
              ImageButton(
                title: 'Report',
                imagePath: 'assets/report.png',
                callback: () => context.go('/reportPage'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

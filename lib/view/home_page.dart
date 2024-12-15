import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sep_hcms/view/widget/image_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            )
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
                callback: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
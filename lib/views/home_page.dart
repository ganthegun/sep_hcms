import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                button('Booking', 'assets/booking.png'),
                button('Schedule', 'assets/schedule.png'),
                button('Activity\nUpdate', 'assets/activity_update.png'),
                button('Payment', 'assets/payment.png'),
                button('Rating', 'assets/rating.png'),
                button('Report', 'assets/report.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget button(String title, String imagePath) {
  return Container(
    margin: title == "Report"
        ? const EdgeInsets.fromLTRB(30, 30, 30, 0)
        : const EdgeInsets.fromLTRB(30, 30, 0, 0),
    height: 150,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start, // this is the default setting
      children: [
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          splashFactory: InkRipple.splashFactory,
          splashColor: Colors.black.withOpacity(0.2),
          child: Ink(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 168, 196, 108),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(
              imagePath,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

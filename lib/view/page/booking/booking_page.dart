import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Center(
          child: Text(
            'Booking Page',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Center(
          child: Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.black.withOpacity(0.2),
              splashFactory: InkRipple.splashFactory,
              onTap: () {},
              child: Ink(
                color: Color.fromARGB(255, 232, 244, 212),
                width: 300,
                height: 100,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/home.png',
                      fit: BoxFit.cover,
                      height: 100,
                      width: 70,
                      alignment: Alignment.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Text(
                        "Booking 1",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
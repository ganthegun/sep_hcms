import 'package:flutter/material.dart';
import 'package:sep_hcms/view/page/booking/booking_form.dart';

class FloatingButton extends StatelessWidget {
  final String path;

  const FloatingButton({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    switch (path) {
      case '/booking':
        return FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) => BookingForm(),
            );
          },
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
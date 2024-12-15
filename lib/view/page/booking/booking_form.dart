import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class BookingForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  BookingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
        child: ListView(
          children: [
            const Text(
              'Add Booking',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: Column(
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
                      child: const Icon(
                        Icons.upload_sharp,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                  ),
                  const Text(
                    'upload image here',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'address',
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      hintText: 'Enter Address',
                    ),
                  ),
                  FormBuilderSlider(
                    name: 'size',
                    initialValue: 0,
                    min: 0,
                    max: 100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../domain/booking.dart';
import '../../../provider/booking_provider.dart';
import '../../../provider/offer_provider.dart';

class OfferForm extends StatelessWidget {
  OfferForm({super.key, required this.id});

  final String id;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, bookingProvider, child) {
        return FutureBuilder(
          future: bookingProvider.show(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading indicator while the data is being fetched
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              // Show an error message if something went wrong
              return Center(
                child: Text('An error occurred: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data == null) {
              // Handle the case where no data is returned
              return const Center(
                child: Text('No booking found.'),
              );
            } else {
              Booking booking = snapshot.data!;
              return SafeArea(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Booking detail",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                context.go('/booking');
                              },
                              icon: Icon(Icons.close)
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Image Slider
                      SizedBox(
                        height: 200, // Set the height of the image slider
                        child: Image.asset(
                          'assets/problem.jpg',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Address:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        booking.address,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Size:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '${booking.houseSize} sqft',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Date:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        "${booking.appointmentDate.day} / ${booking.appointmentDate.month} / ${booking.appointmentDate.year}",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Type:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        booking.houseType,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      FormBuilder(
                        key: _formKey,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Provide offer",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            FormBuilderTextField(
                              name: 'fee',
                              decoration: InputDecoration(
                                  labelText: 'Fee',
                                  hintText: 'Please enter you offer fee',
                                  border: OutlineInputBorder(),
                                  prefixText: "RM"
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.numeric()
                              ]),
                            ),
                            SizedBox(height: 16),
                            FormBuilderDateTimePicker(
                              name: 'appointmentStartTime',
                              inputType: InputType.time, // Ensure this is set to InputType.time
                              decoration: InputDecoration(
                                labelText: 'Start Time',
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.access_time),
                              ),
                              initialDate: DateTime.now(),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                            SizedBox(height: 16),
                            FormBuilderDateTimePicker(
                              name: 'appointmentEndTime',
                              inputType: InputType.time, // Ensure this is set to InputType.time
                              decoration: InputDecoration(
                                labelText: 'End Time',
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.access_time),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                                        final formData = _formKey.currentState!.value;
                                        context.read<OfferProvider>().store(formData, booking.id!);
                                        context.go('/booking');
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Offer created successfully!'),
                                            duration: Duration(seconds: 3), // Adjust the duration as needed
                                          ),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      foregroundColor: Color.fromARGB(255, 168, 196, 108),
                                    ),
                                    child: const Text('Submit'),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      _formKey.currentState?.reset();
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: Color.fromARGB(255, 168, 196, 108),
                                      ),
                                      foregroundColor: Color.fromARGB(255, 168, 196, 108), // Set the text color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                    child: const Text('Reset'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              );
            }
          }
        );
      }
    );
  }
}

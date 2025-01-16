import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sep_hcms/provider/booking_provider.dart';
import '../../../domain/booking.dart';

class BookingForm extends StatelessWidget {
  BookingForm({super.key, this.id});

  final String? id;
  final _formKey = GlobalKey<FormBuilderState>();

  final List<String> _houseTypes = [
    'Bungalow',
    'Semi-D/Detached',
    'Terrace',
    'Town House',
    'Condominium',
    'Apartment',
    'Flat'
  ];

  @override
  Widget build(BuildContext context) {
    if (id != null) {
      return Consumer<BookingProvider>(
        builder: (context, bookingProvider, child) {
          return FutureBuilder(
            future: bookingProvider.show(id!),
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
                return Container(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                  child: FormBuilder(
                    key: _formKey,
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Edit booking",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  context.go('/booking/${booking.id}');
                                },
                                icon: Icon(Icons.close)
                            ),
                          ],
                        ),
                        FormBuilderImagePicker(
                          name: 'images',
                          decoration: const InputDecoration(labelText: 'Image'),
                          maxImages: 10,
                          validator: FormBuilderValidators.required(),
                        ),
                        SizedBox(height: 16),
                        FormBuilderTextField(
                          name: 'address',
                          decoration: InputDecoration(
                            labelText: 'Address',
                            hintText: 'Please enter you address',
                            border: OutlineInputBorder(),
                          ),
                          initialValue: booking.address,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.maxWordsCount(100),
                          ]),
                        ),
                        SizedBox(height: 16),
                        FormBuilderTextField(
                          name: 'houseSize',
                          decoration: InputDecoration(
                              labelText: 'House Size',
                              hintText: 'Please enter you house size',
                              border: OutlineInputBorder(),
                              suffixText: "sqft"
                          ),
                          initialValue: booking.houseSize.toString(),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.numeric()
                          ]),
                        ),
                        SizedBox(height: 16),
                        FormBuilderDateTimePicker(
                          name: 'appointmentDate',
                          inputType: InputType.date,
                          decoration: InputDecoration(
                            labelText: 'Appointment Date',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          format: DateFormat('dd-MM-yyyy'),
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          initialValue: booking.appointmentDate,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                        ),
                        SizedBox(height: 16),
                        FormBuilderDropdown<String>(
                          name: 'houseType',
                          decoration: const InputDecoration(
                            labelText: 'House Type',
                            border: OutlineInputBorder(),
                          ),
                          hint: Text('Please select a house type'),
                          initialValue: booking.houseType,
                          validator: FormBuilderValidators.required(),
                          items: _houseTypes.map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          )).toList(),
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.saveAndValidate() ?? false) {
                                final formData = _formKey.currentState!.value;
                                context.read<BookingProvider>().update(formData, booking.id as String);
                                context.go('/booking/${booking.id}');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Booking updated successfully!'),
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
                            child: const Text('Update'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
          );
        }
      );
    } else {
      return Container(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
        child: FormBuilder(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Add new booking",
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
              FormBuilderImagePicker(
                name: 'images',
                decoration: InputDecoration(
                  labelText: 'Image', // Change icon color
                  border: OutlineInputBorder(), // Optional: Add a border
                ),
                maxImages: 10,
                validator: FormBuilderValidators.required(),
              ),
              SizedBox(height: 16),
              FormBuilderTextField(
                name: 'address',
                decoration: InputDecoration(
                  labelText: 'Address',
                  hintText: 'Please enter you address',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.maxWordsCount(100),
                ]),
              ),
              SizedBox(height: 16),
              FormBuilderTextField(
                name: 'houseSize',
                decoration: InputDecoration(
                    labelText: 'House Size',
                    hintText: 'Please enter you house size',
                    border: OutlineInputBorder(),
                    suffixText: "sqft"
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric()
                ]),
              ),
              SizedBox(height: 16),
              FormBuilderDateTimePicker(
                name: 'appointmentDate',
                inputType: InputType.date,
                decoration: InputDecoration(
                  labelText: 'Appointment Date',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                format: DateFormat('dd-MM-yyyy'),
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              SizedBox(height: 16),
              FormBuilderDropdown<String>(
                name: 'houseType',
                decoration: const InputDecoration(
                  labelText: 'House Type',
                  border: OutlineInputBorder(),
                ),
                hint: Text('Please select a house type'),
                validator: FormBuilderValidators.required(),
                items: _houseTypes.map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type),
                )).toList(),
              ),
              SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          final formData = _formKey.currentState!.value;
                          context.read<BookingProvider>().store(formData);
                          context.go('/booking');
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Booking created successfully!'),
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
        ),
      );
    }
  }
}

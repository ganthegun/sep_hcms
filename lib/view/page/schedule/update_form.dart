import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sep_hcms/domain/schedule.dart';
import 'package:sep_hcms/provider/schedule_provider.dart';

class UpdateForm extends StatelessWidget {
  UpdateForm({super.key, required this.bookingId, required this.offerId});
  final String bookingId;
  final String offerId;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleProvider>(
      builder: (context, bookingProvider, child) {
        return FutureBuilder(
          future: bookingProvider.show(),
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
                child: Text('No schedule found.'),
              );
            } else {
              final schedules = snapshot.data!;
              final schedule = schedules.firstWhere(
                    (schedule) => schedule.bookingId == bookingId && schedule.offerId == offerId,
                orElse: () => Schedule(
                  bookingId: '',
                  address: '',
                  houseSize: 0,
                  appointmentDate: DateTime.now(),
                  houseType: '',
                  bookingStatus: 0,
                  applicationDate: DateTime.now(),
                  offerId: '',
                  fee: 0,
                  appointmentStartTime: DateTime.now(),
                  appointmentEndTime: DateTime.now(),
                  offerStatus: false,
                ),
              );
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
                                context.go('/schedule/$bookingId/$offerId');
                              },
                              icon: Icon(Icons.close)
                          ),
                        ],
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
                        initialValue: schedule.appointmentStartTime,
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
                        initialValue: schedule.appointmentEndTime,
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
                                  context.read<ScheduleProvider>().update(formData, offerId, bookingId, schedule.fee);
                                  context.go('/schedule/${schedule.bookingId}/${schedule.offerId}');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Schedule updated successfully!'),
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
        );
      }
    );
  }
}

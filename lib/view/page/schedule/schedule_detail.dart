import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sep_hcms/domain/schedule.dart';
import 'package:sep_hcms/provider/schedule_provider.dart';

import '../../../provider/offer_provider.dart';

class ScheduleDetail extends StatelessWidget {
  const ScheduleDetail({super.key, required this.bookingId, required this.offerId});
  final String bookingId;
  final String offerId;

  @override
  Widget build(BuildContext context) {
    return Consumer2<ScheduleProvider, OfferProvider> (
      builder: (context, scheduleProvider, offerProvider, child) {
        return FutureBuilder(
          future: scheduleProvider.show(),
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
                return SafeArea(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Schedule detail",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  context.go('/schedule');
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
                            'assets/jackie.jpg',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Address:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          schedule.address,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Size:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          '${NumberFormat.currency(decimalDigits: 2, symbol: '').format(schedule.houseSize)} sqft',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Date:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "${schedule.appointmentDate.day} / ${schedule.appointmentDate.month} / ${schedule.appointmentDate.year}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Type:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          schedule.houseType,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16),

                        Text(
                          'Start Time:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          DateFormat('HH:mm').format(schedule.appointmentStartTime),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'End Time:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          DateFormat('HH:mm').format(schedule.appointmentEndTime),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Fee:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          'RM ${NumberFormat.currency(decimalDigits: 2, symbol: '').format(schedule.fee)}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                context.go('/schedule/update/${schedule.bookingId}/${schedule.offerId}');
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                foregroundColor: Color.fromARGB(255, 168, 196, 108),
                              ),
                              child: const Text('Edit'),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Delete Schedule'),
                                      content: const Text('Are you sure you want to delete this schedule?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context.read<ScheduleProvider>().destroy(offerId, bookingId);
                                            Navigator.of(context).pop();
                                            context.go('/schedule');
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Booking deleted successfully!'),
                                                duration: Duration(seconds: 3), // Adjust the duration as needed
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            'Delete',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                side: BorderSide(
                                  color: Colors.red,
                                ),
                                foregroundColor: Colors.red,
                              ),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
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

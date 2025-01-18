import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sep_hcms/provider/booking_provider.dart';
import 'package:sep_hcms/provider/offer_provider.dart';
import '../../../domain/booking.dart';
import '../../../domain/offer.dart';

class BookingDetail extends StatelessWidget {
  const BookingDetail({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return Consumer2<BookingProvider, OfferProvider>(
      builder: (context, bookingProvider, offerProvider, child) {
        Future<List<dynamic>> fetchData() async {
          return Future.wait([
            bookingProvider.show(id),
            offerProvider.show(id), // Assuming you have a method like this
          ]);
        }
        return FutureBuilder(
          future: fetchData(),
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
              Booking booking = snapshot.data![0];
              Offer? offer = snapshot.data![1];
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
                          'assets/think.jpg',
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
                        '${NumberFormat.currency(decimalDigits: 2, symbol: '').format(booking.houseSize)} sqft',
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
                      Text(
                        'Status:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      booking.status == 0
                          ? Text('Status: Pending Cleaner Acceptance',
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                          : booking.status == 1
                          ? Text('Status: Pending Cleaner Service',
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                          : booking.status == 2
                          ? Text('Status: Completed',
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                          : Text('Status: Unknown',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),
                      booking.status == 0 ?
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              context.go('/offer/update/${booking.id}');
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                              foregroundColor: Color.fromARGB(255, 168, 196, 108),
                            ),
                            child: const Text('View Available Offers'),
                          ),
                        ) : offer!= null? Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start Time:',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              DateFormat('HH:mm').format(offer.appointmentStartTime),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'End Time:',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              DateFormat('HH:mm').format(offer.appointmentEndTime),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Fee:',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              'RM ${NumberFormat.currency(decimalDigits: 2, symbol: '').format(offer.fee)}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                                                ),
                        ) : Placeholder(
                        color: Colors.transparent,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              context.go('/booking/edit/${booking.id}');
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
                                    title: const Text('Delete Booking'),
                                    content: const Text('Are you sure you want to delete this booking?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.read<BookingProvider>().destroy(booking);
                                          Navigator.of(context).pop();
                                          context.go('/booking');
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

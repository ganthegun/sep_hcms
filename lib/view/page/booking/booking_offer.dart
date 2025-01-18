import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/offer.dart';
import '../../../provider/offer_provider.dart';

class BookingOffer extends StatelessWidget {
  const BookingOffer({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return Consumer<OfferProvider>(
      builder: (context, offerProvider, child) {
        return FutureBuilder(
          future: offerProvider.index(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(), // Show a loading indicator
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'), // Show an error message
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No offers found.'), // Show a message if no data
              );
            } else {
              List<Offer> offers = snapshot.data!;
              return SafeArea(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Bookings",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context.go('/booking/$id');
                              },
                              icon: Icon(Icons.close)
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: offers.length,
                            itemBuilder: (context, index) {
                              Offer offer = offers[index];
                              return Card(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Image.asset(
                                            "assets/jackie.jpg",
                                            height: 90,
                                            width: 90,
                                            fit: BoxFit.fitHeight,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          // Text(
                                          //   'Ali',
                                          //   style: TextStyle(
                                          //     fontSize: 16.0,
                                          //     fontWeight: FontWeight.bold,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Fee: RM ${NumberFormat.currency(decimalDigits: 2, symbol: '').format(offer.fee)}',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8.0),
                                            Text(
                                              'Time: ${DateFormat('HH:mm').format(offer.appointmentStartTime)} - ${DateFormat('HH:mm').format(offer.appointmentEndTime)}',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            SizedBox(height: 16.0),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return AlertDialog(
                                                              title: const Text('Accept Offer'),
                                                              content: const Text('Are you sure you want to accept this offer?'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () {
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: const Text('Cancel'),
                                                                ),
                                                                TextButton(
                                                                  onPressed: () {
                                                                    context.read<OfferProvider>().update(offer);
                                                                    Navigator.of(context).pop();
                                                                    context.go('/booking/$id');
                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                      const SnackBar(
                                                                        content: Text('Offer accepted!'),
                                                                        duration: Duration(seconds: 3), // Adjust the duration as needed
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: const Text(
                                                                    'Accept',
                                                                    style: TextStyle(color: Color.fromARGB(255, 168, 196, 108)),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(3),
                                                        ),
                                                        foregroundColor: Color.fromARGB(255, 168, 196, 108),
                                                      ),
                                                      child: Text('Accept'),
                                                    ),
                                                    SizedBox(width: 8.0),
                                                    OutlinedButton(
                                                      onPressed: () {
                                                        context.read<OfferProvider>().destroy(offer);
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          const SnackBar(
                                                            content: Text('Offer rejected!'),
                                                            duration: Duration(seconds: 3), // Adjust the duration as needed
                                                          ),
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
                                                      child: Text('Reject'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          ),
                        ),
                      ],
                    )
                ),
              );
            }
          }
        );
      },

    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sep_hcms/domain/booking.dart';
import 'package:sep_hcms/provider/booking_provider.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, bookingProvider, child) {
        return FutureBuilder(
          future: bookingProvider.index(),
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
                child: Text('No bookings found.'), // Show a message if no data
              );
            } else {
              List<Booking> bookings = snapshot.data!;
              bookings.sort((a, b) => b.applicationDate.compareTo(a.applicationDate));
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
                                context.go('/');
                              },
                              icon: Icon(Icons.close),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: bookings.length,
                          itemBuilder: (context, index) {
                            Booking booking = bookings[index];
                            return Card(
                              clipBehavior: Clip.hardEdge,
                              margin: const EdgeInsets.all(10), // Add margin for spacing
                              child: InkWell(
                                splashColor: Colors.black.withOpacity(0.2),
                                splashFactory: InkRipple.splashFactory,
                                onTap: () {
                                  context.go('/booking/${booking.id}');
                                },
                                child: Ink(
                                  color: const Color.fromARGB(255, 232, 244, 212),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/home.png',
                                        fit: BoxFit.cover,
                                        height: 70,
                                        width: 70,
                                        alignment: Alignment.center,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: ListTile(
                                            title: Text("Booking ${bookings.length - index} \n${booking.address}"),
                                            subtitle:
                                            booking.status == 0
                                                ? Text('Status: Pending Cleaner Acceptance')
                                                : booking.status == 1
                                                ? Text('Status: Pending Cleaner Service')
                                                : booking.status == 2
                                                ? Text('Status: Completed')
                                                : Text('Status: Unknown'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
    // return Consumer<BookingProvider>(
    //   builder: (context, bookingProvider, child) {
    //     return FutureBuilder(
    //       future: bookingProvider.index(),
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           return const Center(
    //             child: CircularProgressIndicator(), // Show a loading indicator
    //           );
    //         } else if (snapshot.hasError) {
    //           return Center(
    //             child: Text('Error: ${snapshot.error}'), // Show an error message
    //           );
    //         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
    //           return const Center(
    //             child: Text('No bookings found.'), // Show a message if no data
    //           );
    //         } else {
    //           List<Booking> bookings = snapshot.data!;
    //           bookings.sort((a, b) => b.applicationDate.compareTo(a.applicationDate));
    //           return SafeArea(
    //             child: Container(
    //               padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
    //               child: Column(
    //                 children: [
    //                   Row(
    //                     children: [
    //                       Expanded(
    //                         child: Text(
    //                           "Bookings",
    //                           style: TextStyle(
    //                             fontSize: 24,
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                         ),
    //                       ),
    //                       IconButton(
    //                           onPressed: () {
    //                             context.go('/');
    //                           },
    //                           icon: Icon(Icons.close)
    //                       ),
    //                     ],
    //                   ),
    //                   Expanded(
    //                     child: ListView.builder(
    //                       itemCount: bookings.length,
    //                       itemBuilder: (context, index) {
    //                         Booking booking = bookings[index];
    //                         return Card(
    //                           clipBehavior: Clip.hardEdge,
    //                           margin: const EdgeInsets.all(10), // Add margin for spacing
    //                           child: InkWell(
    //                             splashColor: Colors.black.withOpacity(0.2),
    //                             splashFactory: InkRipple.splashFactory,
    //                             onTap: () {
    //                               context.go('/offer/create/${booking.id}');
    //                             },
    //                             child: Ink(
    //                               color: const Color.fromARGB(255, 232, 244, 212),
    //                               child: Row(
    //                                 children: [
    //                                   Image.asset(
    //                                     'assets/home.png',
    //                                     fit: BoxFit.cover,
    //                                     height: 70,
    //                                     width: 70,
    //                                     alignment: Alignment.center,
    //                                   ),
    //                                   Expanded(
    //                                     child: Padding(
    //                                       padding: const EdgeInsets.only(left: 10),
    //                                       child: ListTile(
    //                                         title: Text("Booking ${bookings.length - index} \n${booking.address}"),
    //                                         subtitle:
    //                                         booking.status == 0
    //                                             ? Text('Status: Pending Cleaner Acceptance')
    //                                             : booking.status == 1
    //                                             ? Text('Status: Pending Cleaner Service')
    //                                             : booking.status == 2
    //                                             ? Text('Status: Completed')
    //                                             : Text('Status: Unknown'),
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                           ),
    //                         );
    //                       },
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           );
    //         }
    //       },
    //     );
    //   },
    // );
  }
}
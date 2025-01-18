import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  // Fetch completed bookings for the current user
  Stream<QuerySnapshot> getCompletedBookings() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance
          .collection('bookings')
          .where('user_id', isEqualTo: user.uid)
          .where('status', isEqualTo: 1)
          .snapshots();
    }
    return const Stream.empty();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Completed Cleaning Services',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getCompletedBookings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No completed bookings found.'));
          }

          final bookings = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index].data() as Map<String, dynamic>;
              return _buildBookingCard(context, booking, index + 1); // Pass the index + 1 as booking number
            },
          );
        },
      ),
    );
  }

  // Build a card for each booking
  Widget _buildBookingCard(BuildContext context, Map<String, dynamic> booking, int bookingNumber) {
    return Card(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        splashColor: const Color.fromARGB(255, 199, 199, 199),
        onTap: () {
          _showBookingDetailsModal(context, booking);
        },
        child: Ink(
          color: const Color.fromARGB(255, 232, 244, 212),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/home.png',
                  fit: BoxFit.cover,
                  height: 100,
                  width: 70,
                  alignment: Alignment.center,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          'Service $bookingNumber', // Use the dynamic booking number
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 125, 185, 14),
                            elevation: 5,
                          ),
                          onPressed: () {
                            _showBookingDetailsModal(context, booking);
                          },
                          child: const Text(
                            'View',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 231, 231, 231),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Show booking details in a modal
  void _showBookingDetailsModal(BuildContext context, Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Booking Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Address: ${booking['address'] ?? 'N/A'}"),
                Text("House Type: ${booking['houseType'] ?? 'N/A'}"),
                Text("House Size: ${booking['houseSize']?.toString() ?? 'N/A'} sqft"),
                Text("Appointment Date: ${_formatTimestamp(booking['appointmentDate'])}"),
                Text("Application Date: ${_formatTimestamp(booking['applicationDate'])}"),
                Text("Status: ${_getStatusText(booking['status'])}"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  String _formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return 'N/A';
    return DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch)
        .toString()
        .split('.')
        .first;
  }

  String _getStatusText(int? status) {
    switch (status) {
      case 1:
        return 'Completed';
      default:
        return 'Unknown';
    }
  }
}
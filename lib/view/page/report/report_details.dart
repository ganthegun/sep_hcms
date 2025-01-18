import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportDetails extends StatelessWidget {
  final Map<String, dynamic> booking;

  const ReportDetails({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Service Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
              const SizedBox(width: 20),
              Transform.rotate(
                angle: -0.3,
                child: const Icon(
                  Icons.menu_book_sharp,
                  size: 40,
                ),
              ),
            ],
          ),
          Container(
            color: const Color.fromARGB(255, 232, 244, 212),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/home.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Table(
                  children: [
                    _buildTableRow('Owner: ', booking['owner_name'] ?? 'N/A'),
                    _buildTableRow('Cleaner: ', booking['cleaner_name'] ?? 'N/A'),
                    _buildTableRow('Address: ', booking['booking_address'] ?? 'N/A'),
                    _buildTableRow('House Size: ', '${booking['booking_houseSize']?.toString() ?? 'N/A'} sqft'),
                    _buildTableRow('Start Date: ', _formatTimestamp(booking['booking_appointmentDate'])),
                    _buildTableRow('End Date: ', _formatTimestamp(booking['booking_endDate'])),
                    _buildTableRow('House Type: ', booking['booking_houseType'] ?? 'N/A'),
                    _buildTableRow('Status: ', _getStatusText(booking['status'])),
                    _buildTableRow('Fee: ', 'RM ${booking['booking_fee']?.toStringAsFixed(2) ?? 'N/A'}'),
                    _buildTableRow('Payment Method: ', booking['payment_method'] ?? 'N/A'),
                    _buildTableRow('Rating: ', '${booking['rating']?.toString() ?? 'N/A'}/5'),
                    _buildTableRow('Feedback: ', booking['feedback'] ?? 'N/A'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build a TableRow
  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(value),
        ),
      ],
    );
  }

  // Format Firestore Timestamp to a readable string
  String _formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return 'N/A';
    return DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch)
        .toString()
        .split('.')
        .first;
  }

  // Convert status integer to text
  String _getStatusText(int? status) {
    switch (status) {
      case 1:
        return 'Completed';
      default:
        return 'Unknown';
    }
  }
}
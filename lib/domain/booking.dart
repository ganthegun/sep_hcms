import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  String? id;
  // List<String> images;
  String address;
  double houseSize;
  DateTime appointmentDate;
  String houseType;
  int status;
  DateTime applicationDate;
  //String userId;

  Booking({
    this.id,
    required this.address,
    required this.houseSize,
    required this.appointmentDate,
    required this.houseType,
    required this.status,
    required this.applicationDate,
  });

  Future<void> create() async {
    try {
      final CollectionReference bookings = FirebaseFirestore.instance.collection('bookings');

      Map<String, dynamic> bookingData = {
        'address': address,
        'houseSize': houseSize,
        'appointmentDate': Timestamp.fromDate(appointmentDate),
        'houseType': houseType,
        'status': status,
        'applicationDate': Timestamp.fromDate(applicationDate),
      };
      await bookings.add(bookingData);
    } catch (e) {
      throw Exception('Failed to create booking: $e');
    }
  }

  static Future<List<Booking>> read() async {
    try {
      final CollectionReference bookings = FirebaseFirestore.instance.collection('bookings');
      QuerySnapshot querySnapshot = await bookings.get();
      List<Booking> bookingList = querySnapshot.docs.map(
        (doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return Booking(
            id: doc.id,
            address: data['address'],
            houseSize: data['houseSize'],
            appointmentDate: data['appointmentDate'].toDate(),
            houseType: data['houseType'],
            status: data['status'],
            applicationDate: data['applicationDate'].toDate(),
          );
        }
      ).toList();
      return bookingList;
    } catch (e) {
      return [];
    }
  }

  Future<void> update() async {
    try {
      final CollectionReference bookings = FirebaseFirestore.instance.collection('bookings');

      Map<String, dynamic> bookingData = {
        'address': address,
        'houseSize': houseSize,
        'appointmentDate': appointmentDate,
        'houseType': houseType,
      };
      await bookings.doc(id).update(bookingData);
    } catch (e) {
      throw Exception('Failed to update booking: $e');
    }
  }

  Future<void> delete(String id) async {
    try {
      final CollectionReference bookings = FirebaseFirestore.instance.collection('bookings');
      bookings.doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete booking: $e');
    }
  }
}
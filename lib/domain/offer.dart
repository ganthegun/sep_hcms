import 'package:cloud_firestore/cloud_firestore.dart';

class Offer {
  String? id;
  String bookingId;
  // String cleanerId;
  double fee;
  DateTime appointmentStartTime;
  DateTime appointmentEndTime;
  bool status;

  Offer({
    this.id,
    required this.bookingId,
    required this.fee,
    required this.appointmentStartTime,
    required this.appointmentEndTime,
    required this.status
  });

  Future<void> create() async {
    try {
      final CollectionReference offers = FirebaseFirestore.instance.collection('offers');
      Map<String, dynamic> offerData = {
        'bookingId': bookingId,
        'fee': fee,
        'appointmentStartTime': appointmentStartTime,
        'appointmentEndTime': appointmentEndTime,
        'status': status
      };
      await offers.add(offerData);
    } catch (e) {
      throw Exception('Failed to create offer: $e');
    }
  }

  static Future<List<Offer>> read(String bookingId) async {
    try {
      final CollectionReference offers = FirebaseFirestore.instance.collection('offers');
      QuerySnapshot querySnapshot = await offers.where('bookingId', isEqualTo: bookingId).get();
      List<Offer> offerList = querySnapshot.docs.map(
            (doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return Offer(
            id: doc.id,
            bookingId: data['bookingId'],
            fee: data['fee'],
            appointmentStartTime: data['appointmentStartTime'].toDate(),
            appointmentEndTime: data['appointmentEndTime'].toDate(),
            status: data['status'],
          );
        }
      ).toList();
      return offerList;
    } catch (e) {
      return [];
    }
  }

  Future<void> update() async {
    try {
      final CollectionReference offers = FirebaseFirestore.instance.collection('offers');
      Map<String, dynamic> offerData = {
        'status': true,
        'appointmentStartTime': appointmentStartTime,
        'appointmentEndTime': appointmentEndTime,
      };
      await offers.doc(id).update(offerData);

      final CollectionReference bookings = FirebaseFirestore.instance.collection('bookings');
      Map<String, dynamic> bookingData = {
        'status': 1,
      };
      await bookings.doc(bookingId).update(bookingData);

    } catch (e) {
      throw Exception('Failed to update offer: $e');
    }
  }

  Future<void> delete() async {
    try {
      final CollectionReference offers = FirebaseFirestore.instance.collection('offers');
      offers.doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete booking: $e');
    }
  }
}
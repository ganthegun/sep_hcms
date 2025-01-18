import 'package:cloud_firestore/cloud_firestore.dart';
import 'booking.dart';
import 'offer.dart'; // Assuming you have an Offer class

class Schedule {
  String bookingId;
  String address;
  double houseSize;
  DateTime appointmentDate;
  String houseType;
  int bookingStatus;
  DateTime applicationDate;
  String offerId;
  double fee;
  DateTime appointmentStartTime;
  DateTime appointmentEndTime;
  bool offerStatus;

  Schedule({
    required this.bookingId,
    required this.address,
    required this.houseSize,
    required this.appointmentDate,
    required this.houseType,
    required this.bookingStatus,
    required this.applicationDate,
    required this.offerId,
    required this.fee,
    required this.appointmentStartTime,
    required this.appointmentEndTime,
    required this.offerStatus,
  });

  static Future<List<Schedule>> read() async {
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

      final CollectionReference offers = FirebaseFirestore.instance.collection('offers');
      QuerySnapshot querySnapshot2 = await offers.get();
      List<Offer> offerList = querySnapshot2.docs.map(
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

      // Combine the two lists based on bookingId, only adding bookings with offers
      List<Schedule> scheduleList = [];
      for (var booking in bookingList) {
        var offer = offerList.firstWhere(
              (offer) => offer.bookingId == booking.id,
          orElse: () => Offer(
            id: '',
            bookingId: '',
            fee: 0.0,
            appointmentStartTime: DateTime.now(),
            appointmentEndTime: DateTime.now(),
            status: false,
          ),
        );

        // Only add to scheduleList if the offer has a valid bookingId
        if (offer.bookingId.isNotEmpty) {
          scheduleList.add(Schedule(
            bookingId: booking.id!,
            address: booking.address,
            houseSize: booking.houseSize,
            appointmentDate: booking.appointmentDate,
            houseType: booking.houseType,
            bookingStatus: booking.status,
            applicationDate: booking.applicationDate,
            offerId: offer.id!,
            fee: offer.fee,
            appointmentStartTime: offer.appointmentStartTime,
            appointmentEndTime: offer.appointmentEndTime,
            offerStatus: offer.status,
          ));
        }
      }

      return scheduleList;
    } catch (e) {
      return [];
    }
  }

  static Future<void> delete(String offerId, String bookingId) async {
    try {
      final CollectionReference offers = FirebaseFirestore.instance.collection('offers');
      offers.doc(offerId).delete();

      final CollectionReference bookings = FirebaseFirestore.instance.collection('bookings');
      Map<String, dynamic> bookingData = {
        'status': 0,
      };
      await bookings.doc(bookingId).update(bookingData);
    } catch (e) {
      throw Exception('Failed to delete schedule: $e');
    }
  }
}
import 'package:flutter/material.dart';
import '../domain/offer.dart';
import '../domain/schedule.dart';

class ScheduleProvider extends ChangeNotifier {

  Future<List<Schedule>> show() async {
    try {
      // Fetch all schedules
      List<Schedule> schedules = await Schedule.read();

      // Filter schedules to include only those with offerStatus == true
      List<Schedule> filteredSchedules = schedules.where((schedule) => schedule.offerStatus == true).toList();

      return filteredSchedules;
    } catch (e) {
      return [];
    }
  }

  Future<void> update(Map<String, dynamic> formData, String offerId, String bookingId, double fee) async {
    try {
       Offer offer = Offer(
        id: offerId,
        bookingId: bookingId,
        fee: fee,
        appointmentStartTime: formData['appointmentStartTime'],
        appointmentEndTime: formData['appointmentEndTime'],
        status: true,
      );
      await offer.update();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to update booking: $e');
    }
  }

  Future<void> destroy(String offerId, String bookingId) async {
    try {
      Schedule.delete(offerId, bookingId);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete booking: $e');
    }
  }
}
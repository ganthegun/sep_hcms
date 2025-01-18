import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sep_hcms/domain/booking.dart';

class BookingProvider extends ChangeNotifier {

  Future<List<Booking>> index() async {
    try {
      List<Booking> bookings = await Booking.read();
      return bookings;
    } catch (e) {
      return [];
    }
  }

  Future<void> store(Map<String, dynamic> formData) async {
    try {
      Booking booking = Booking(
        address: formData['address'],
        houseSize: double.parse(formData['houseSize']),
        appointmentDate: formData['appointmentDate'],
        houseType: formData['houseType'],
        status: 0,
        applicationDate: DateTime.now(),
      );
      await booking.create();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to create booking: $e');
    }
  }

  Future<Booking> show(String id) async {
    try {
      List<Booking> bookings = await Booking.read();
      for (var booking in bookings) {
        if (booking.id == id) {
          return booking;
        }
      }
      throw Exception('Booking with id $id not found');
    } catch (e) {
      throw Exception('Failed to fetch booking: $e');
    }
  }

  Future<void> update(Map<String, dynamic> formData, String id) async {
    try {
      Booking booking = Booking(
        id: id,
        address: formData['address'],
        houseSize: double.parse(formData['houseSize']),
        appointmentDate: formData['appointmentDate'],
        houseType: formData['houseType'],
        status: 0,
        applicationDate: DateTime.now(),
      );
      await booking.update();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to update booking: $e');
    }
  }

  Future<void> destroy(Booking booking) async {
    try {
      booking.delete(booking.id!);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete booking: $e');
    }
  }
}
import 'package:flutter/material.dart';
import '../domain/offer.dart';

class OfferProvider extends ChangeNotifier {

  Future<List<Offer>> index(String bookingId) async {
    try {
      List<Offer> offers = await Offer.read(bookingId);
      return offers;
    } catch (e) {
      return [];
    }
  }

  Future<void> store(Map<String, dynamic> formData, String bookingId) async {
    try {
      Offer offer = Offer(
        bookingId: bookingId,
        fee: double.parse(formData['fee']),
        appointmentStartTime: formData['appointmentStartTime'],
        appointmentEndTime: formData['appointmentEndTime'],
        status: false,
      );
      await offer.create();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to create offer: $e');
    }
  }

  Future<Offer?> show(String bookingId) async {
    try {
      List<Offer> offers = await Offer.read(bookingId);
      for (var offer in offers) {
        if (offer.bookingId == bookingId && offer.status == true) {
          return offer;
        }
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch offer: $e');
    }
  }

  Future<void> update(Offer offer) async {
    try {
      await offer.update();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to update booking: $e');
    }
  }

  Future<void> destroy(Offer offer) async {
    try {
      offer.delete();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete booking: $e');
    }
  }
}

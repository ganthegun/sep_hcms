import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sep_hcms/view/page/booking/booking_offer.dart';
import 'package:sep_hcms/view/page/booking/offer_form.dart';
import 'package:sep_hcms/view/page/schedule/schedule_detail.dart';
import 'package:sep_hcms/view/page/schedule/schedule_page.dart';
import 'package:sep_hcms/view/page/schedule/update_form.dart';
import 'package:sep_hcms/view/widget/floating_button.dart';
import 'package:sep_hcms/view/widget/nav_bar.dart';
import 'package:sep_hcms/view/home_page.dart';
import 'package:sep_hcms/view/page/booking/booking_page.dart';
import 'package:sep_hcms/view/page/booking/booking_form.dart';
import 'package:sep_hcms/view/page/booking/booking_detail.dart';

var router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: const NavBar(),
          floatingActionButton: FloatingButton(path: state.uri.path),
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: '/booking',
          builder: (context, state) => BookingPage(),
        ),
        GoRoute(
          path: '/booking/create',
          builder: (context, state) => BookingForm(),
        ),
        GoRoute(
          path: '/booking/:id',
          builder: (context, state) {
            final String id = state.pathParameters['id']!;
            return BookingDetail(id: id);
          },
        ),
        GoRoute(
          path: '/booking/edit/:id',
          builder: (context, state) {
            final String id = state.pathParameters['id']!;
            return BookingForm(id: id);
          },
        ),
        GoRoute(
          path: '/offer/create/:id',
          builder: (context, state) {
            final String id = state.pathParameters['id']!;
            return OfferForm(id: id);
          },
        ),
        GoRoute(
          path: '/offer/update/:id',
          builder: (context, state) {
            final String id = state.pathParameters['id']!;
            return BookingOffer(id: id);
          },
        ),
        GoRoute(
          path: '/schedule',
          builder: (context, state) => SchedulePage(),
        ),
        GoRoute(
          path: '/schedule/:booking/:offer',
          builder: (context, state) {
            final String bookingId = state.pathParameters['booking']!;
            final String offerId = state.pathParameters['offer']!;
            return ScheduleDetail(bookingId: bookingId, offerId: offerId);
          },
        ),
        GoRoute(
          path: '/schedule/update/:booking/:offer',
          builder: (context, state) {
            final String bookingId = state.pathParameters['booking']!;
            final String offerId = state.pathParameters['offer']!;
            return UpdateForm(bookingId: bookingId, offerId: offerId);
          },
        ),
      ],
    ),
  ],
);
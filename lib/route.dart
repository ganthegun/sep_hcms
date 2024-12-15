import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sep_hcms/view/widget/floating_button.dart';
import 'package:sep_hcms/view/widget/nav_bar.dart';
import 'package:sep_hcms/view/home_page.dart';
import 'package:sep_hcms/view/page/booking/booking_page.dart';

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
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/booking',
          builder: (context, state) => const BookingPage(),
        ),
      ],
    ),
  ],
);
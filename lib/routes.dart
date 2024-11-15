import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sep_hcms/widget/nav_bar.dart';
import 'package:sep_hcms/views/home_page.dart';

var router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      // navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: const NavBar(),
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
      ],
    ),
  ],
);

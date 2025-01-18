import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sep_hcms/view/widget/floating_button.dart';
import 'package:sep_hcms/view/widget/nav_bar.dart';
import 'package:sep_hcms/view/home_page.dart';
import 'package:sep_hcms/view/page/booking/booking_page.dart';
import 'package:sep_hcms/view/page/loginUserProfile/login_page.dart';
import 'package:sep_hcms/view/page/loginUserProfile/login_error.dart';
import 'package:sep_hcms/view/page/loginUserProfile/sign_up_page.dart';
import 'package:sep_hcms/view/page/loginUserProfile/sign_up_error.dart';
import 'package:sep_hcms/view/page/loginUserProfile/user_profile_page.dart';
import 'package:sep_hcms/view/page/loginUserProfile/user_profile_edit_form.dart';
import 'package:sep_hcms/view/page/loginUserProfile/user_profile_edit_error.dart';
import 'package:sep_hcms/view/page/loginUserProfile/user_profile_edit_success.dart';
import 'package:sep_hcms/provider/login_user_profile_provider.dart';
import 'package:sep_hcms/view/page/report/report_page.dart';
import 'package:sep_hcms/view/page/report/report_details.dart';

final LoginUserProfileProvider controller = LoginUserProfileProvider();

var router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) {
        final excludedPaths = [
          '/',
          '/loginError',
          '/signUpPage',
          '/signUpError',
        ];
        final isExcluded = excludedPaths.contains(state.uri.path);

        return Scaffold(
          body: child,
          bottomNavigationBar: isExcluded ? null : const NavBar(),
          floatingActionButton:
              isExcluded ? null : FloatingButton(path: state.uri.path),
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/loginError',
          builder: (context, state) => const LoginError(),
        ),
        GoRoute(
          path: '/signUpPage',
          builder: (context, state) => const SignUpPage(),
        ),
        GoRoute(
          path: '/signUpError',
          builder: (context, state) => const SignUpError(),
        ),
        GoRoute(
          path: '/homePage',
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: '/userProfilePage',
          builder: (context, state) =>
              UserProfilePage(controller: LoginUserProfileProvider()),
        ),
        GoRoute(
          path: '/userProfileEditForm',
          builder: (context, state) =>
              UserProfileEditForm(controller: LoginUserProfileProvider()),
        ),
        GoRoute(
          path: '/userProfileEditError',
          builder: (context, state) => const UserProfileEditError(),
        ),
        GoRoute(
          path: '/userProfileEditSuccess',
          builder: (context, state) => const UserProfileEditSuccess(),
        ),
        GoRoute(
          path: '/reportPage',
          builder: (context, state) => const ReportPage(),
        ),
        GoRoute(
          path: '/reportDetails',
          builder: (context, state) {
            final booking = state.extra as Map<String, dynamic>;
            return ReportDetails(booking: booking);
          },
        ),
        GoRoute(
          path: '/booking',
          builder: (context, state) => const BookingPage(),
        ),
      ],
    ),
  ],
);

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: SafeArea(
        child: Container(
          color: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 10,
              activeColor: const Color.fromARGB(255, 168, 196, 108),
              iconSize: 30,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              duration: const Duration(milliseconds: 300),
              backgroundColor: Colors.grey[100]!,
              tabBackgroundColor: Colors.white,
              haptic: true,
              onTabChange: (index) {
                switch (index) {
                  case 0:
                    context.go('/');
                    break;
                  case 1:
                  // include route to inbox
                    break;
                  case 2:
                  // include route to user profile
                    break;
                }
              },
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.inbox,
                  text: 'Inbox',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
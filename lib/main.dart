import 'package:flutter/material.dart';
import 'package:sep_hcms/route.dart';

void main() async {
  runApp(
    MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    ),
  );
}
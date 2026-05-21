import 'dart:io';

import 'package:flutter/material.dart';
import "api/api_service.dart";
import 'package:wordpress_app/ui/signup/signup_page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(PlantApp());
}

class PlantApp extends StatelessWidget {
  const PlantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        title: "Plant App",
        debugShowCheckedModeBanner: false,
        home: SignupPage(),
      ),
    );
  }
}

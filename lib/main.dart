import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wordpress_app/providers/post_provider.dart';
import 'package:wordpress_app/providers/shop_provider.dart';
import 'package:wordpress_app/ui/login_page/login_page.dart';
import 'package:wordpress_app/ui/root/root.dart';
import "api/api_service.dart";
import "package:provider/provider.dart";

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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ShopProvider()),
        ChangeNotifierProvider(create: (context) => PostProvider()),
      ],
      child: PlantApp(),
    ),
  );
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
        home: RootPage(),
      ),
    );
  }
}

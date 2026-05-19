import 'package:flutter/material.dart';

import 'package:wordpress_app/ui/root/root.dart';
import 'package:wordpress_app/ui/signup/signup_page.dart';
// import 'package:wordpress_app/ui/splash_page.dart';


void main(){
  runApp(PlantApp());
}
class PlantApp extends StatelessWidget {
  const PlantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: MaterialApp(
        theme:ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        title:"Plant App",
        debugShowCheckedModeBanner:false,
        home:SignupPage()
      ),
    );
  }
}
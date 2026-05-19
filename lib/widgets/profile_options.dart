import 'package:flutter/material.dart';
import "package:wordpress_app/constants/constants.dart";

class Options extends StatelessWidget {
  final String text;
  final IconData icon;
  const Options({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.arrow_back_ios,
            color: Constants.greyColor.withValues(alpha: .9),
            size: 17,
          ),
          Row(
            children: [
              Text(
                text,
                style: TextStyle(
                  fontFamily: "yekan",
                  fontSize: 18,
                  color: Constants.greyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 5),
              Icon(icon, color: Constants.greyColor.withValues(alpha: .9)),
            ],
          ),
        ],
      ),
    );
  }
}

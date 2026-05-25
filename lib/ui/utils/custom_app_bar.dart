import "package:flutter/material.dart";
import "package:wordpress_app/constants/constants.dart";

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment:.center,
        children: [
          // X Button
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Constants.primaryColor.withValues(alpha: .3),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, color: Constants.primaryColor),
            ),
          ),
          // text
          Text(
            title,
            style: TextStyle(
              color: Constants.primaryColor,
              fontFamily: "laleh",
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}

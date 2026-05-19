import "package:flutter/material.dart";
import "package:wordpress_app/constants/constants.dart";
import "package:wordpress_app/widgets/profile_options.dart";

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Container(
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: BoxBorder.all(
                  width: 5,
                  color: Constants.primaryColor.withValues(alpha: .5),
                ),
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/profile.jpg"),
                radius: 60,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "ساناز امینی",
                  style: TextStyle(
                    fontFamily: "yekan",
                    fontWeight: FontWeight.w100,
                    fontSize: 20,
                    color: Constants.blackColor,
                  ),
                ),
                SizedBox(width: 5),
                SizedBox(
                  height: 15,
                  child: Image.asset("assets/images/verified.png"),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Sanaz@gmail.com",
              style: TextStyle(
                fontSize: 16,
                color: Constants.greyColor.withValues(alpha: .8),
              ),
            ),
            SizedBox(height: 30),
            Column(
              children: [
                Options(text: "پروفایل من", icon: Icons.person),
                Options(text: "تنظیمات", icon: Icons.settings),
                Options(text: "اطلاع رسانی‌ها", icon: Icons.notifications),
                Options(text: "شبکه‌های اجتماعی", icon: Icons.share),
                Options(text: "خروج", icon: Icons.logout),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

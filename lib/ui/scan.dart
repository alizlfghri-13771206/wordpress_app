import "package:flutter/material.dart";
import "package:wordpress_app/constants/constants.dart";

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 20,
            right: 20,
            top: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Constants.primaryColor.withValues(alpha: .2),
                    shape: BoxShape.circle,
                  ),
                  height: 40,
                  width: 40,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, color: Constants.primaryColor),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Constants.primaryColor.withValues(alpha: .2),
                    shape: BoxShape.circle,
                  ),
                  height: 40,
                  width: 40,
                  child: Icon(Icons.share_sharp, color: Constants.primaryColor),
                ),
              ],
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            top: 80,
            // top: 200,
            child: SizedBox(
              width: size.width * .8,
              height: size.height * .8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      "assets/images/code-scan.png",
                      height: 100,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "برای اسکن گیاهان کلیک کنید",
                    style: TextStyle(
                      color: Constants.primaryColor.withValues(alpha: .7),
                      fontSize: 25,
                      fontFamily: "laleh",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

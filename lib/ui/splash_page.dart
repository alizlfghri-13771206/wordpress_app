import 'package:flutter/material.dart';
import "package:wordpress_app/constants/constants.dart";
import 'package:wordpress_app/ui/root/root.dart';
import 'package:page_transition/page_transition.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final PageController _controller = PageController(initialPage: 0);
  int currentIndex = 0;

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 5),
      duration: Duration(microseconds: 600),
      decoration: BoxDecoration(
        color: Constants.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 10,
      width: isActive ? 20 : 8,
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (i == currentIndex) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>RootPage()));
              },
              child: const Text(
                "رد کردن",
                style: TextStyle(
                  fontFamily: "laleh",
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          
          PageView(
            controller: _controller,
            onPageChanged: (int value) {
              setState(() => currentIndex = value);
            },
            children: <Widget>[
              Pages(
                image: "assets/images/plant-one.png",
                title: Constants.titleOne,
                description: Constants.descriptionOne,
              ),
              Pages(
                image: "assets/images/plant-two.png",
                title: Constants.titleTwo,
                description: Constants.descriptionTwo,
              ),
              Pages(
                image: "assets/images/plant-three.png",
                title: Constants.titleThree,
                description: Constants.descriptionThree,
              ),
            ],
          ),
          Positioned(
            left: 20,
            bottom: 60,
            child: Row(children: _buildIndicator()),
          ),
          Positioned(
            right: 20,
            bottom: 40,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Constants.primaryColor,
                shape: BoxShape.circle,
              ),
              height: 50,
              width: 50,
              child: IconButton(
                onPressed: () {
                    if (currentIndex < 2) {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.linear,
                        );

                    } else if (currentIndex == 2) {
                      Navigator.of(context).push(
                        PageTransition(
                          duration: Duration(milliseconds: 300),
                          childBuilder: (context) => RootPage(), type: PageTransitionType.leftToRight),
                      );
                    }
                  
                },
                icon: Icon(Icons.arrow_forward_ios),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Pages extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  const Pages({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0, right: 50, bottom: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 350, child: Image.asset(image)),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "yekan",
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Constants.primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "sans",
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}



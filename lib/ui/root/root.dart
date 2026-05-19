import "package:flutter/material.dart";

import "package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart";
import "package:page_transition/page_transition.dart";

import "package:wordpress_app/constants/constants.dart";
import "package:wordpress_app/models/plant.dart";
import "package:wordpress_app/ui/favorite.dart";
import "package:wordpress_app/ui/home/home.dart";
import "package:wordpress_app/ui/profile/profile.dart";
import "package:wordpress_app/ui/scan.dart";
import "package:wordpress_app/ui/cart_page/shopping_cart.dart";
import "package:wordpress_app/ui/signup/signup_page.dart";

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  List<Plant> favorited=[];
  List<Plant> selectedToBuy=[];
  int bottomIndex = 0;

  List<Widget> pages(){
    return [
      HomePage(),
      FavoritePage(favoritedPlants: favorited,),
      ShoppingCart(inShoppingCartPlants: selectedToBuy,),
      Profile(),
    ];
  }

  List<IconData> icons = [
    Icons.home,
    Icons.favorite,
    Icons.shopping_cart,
    Icons.person,
  ];

  List<String> appbarTitles = ["خانه", "علاقمندی‌ها", "سبد خرید", "پروفایل"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white70,
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.notifications, size: 30, color: Constants.greyColor),
              Text(
                appbarTitles[bottomIndex],
                style: TextStyle(
                  fontFamily: "laleh",
                  fontSize: 25,
                  color: Constants.greyColor,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        shadow: BoxShadow(
          color: const Color.fromARGB(84, 0, 0, 0),
          blurRadius: 3,
        ),
        activeIndex: bottomIndex,
        icons: icons,
        gapLocation: GapLocation.center,
        activeColor: Constants.primaryColor,
        inactiveColor: Constants.greyColor,
        splashColor: Constants.primaryColor,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (int value) {
          setState(() {
            bottomIndex = value;
            List<Plant> fave=Plant.getFavoritedPlants();
            List<Plant> buy=Plant.addedToCartPlants();
            favorited=fave;
            selectedToBuy=buy;
            
          });

        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.bottomToTop,
              child: ScanPage(),
            ),
          );
        },
        shape: CircleBorder(),
        child: Image.asset("assets/images/code-scan-two.png", height: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: IndexedStack(index: bottomIndex, children: pages()),
    );
  }
}

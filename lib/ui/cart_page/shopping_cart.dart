import "package:flutter/material.dart";
import "package:wordpress_app/constants/constants.dart";
import "package:wordpress_app/models/plant.dart";
import "package:wordpress_app/widgets/extentions.dart";
import "package:wordpress_app/widgets/plant_widget.dart";

class ShoppingCart extends StatefulWidget {
  final List<Plant> inShoppingCartPlants;
  const ShoppingCart({super.key, required this.inShoppingCartPlants});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  int sumPrices() {
    int sum = 0;
    if (widget.inShoppingCartPlants.isNotEmpty) {
      int lengthOfPlant = widget.inShoppingCartPlants.length;
      for (int i = 0; i < lengthOfPlant; i++) {
        sum = sum + widget.inShoppingCartPlants[i].price;
      }
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.inShoppingCartPlants.isNotEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 12),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: widget.inShoppingCartPlants.length,
                      itemBuilder: (context, index) {
                        return NewPlantWidget(
                          plantList: widget.inShoppingCartPlants,
                          index: index,
                        );
                      },
                    ),
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 20,
                              child: Image.asset(
                                "assets/images/PriceUnit-green.png",
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "${sumPrices().toString().farsiNumber}${"000".farsiNumber}",
                              style: TextStyle(
                                fontFamily: "laleh",
                                fontSize: 25,
                                color: Constants.primaryColor,
                              ),
                            ),
                          ],
                        ),

                        Text(
                          "جمع کل : ",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontFamily: "laleh", fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    child: Image.asset("assets/images/add-cart.png"),
                  ),
                  Text(
                    "سبد خرید تار عنکبوت بسته :|",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "sans",
                      color: Constants.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

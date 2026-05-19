import "package:flutter/material.dart";
import "package:wordpress_app/constants/constants.dart";
import "package:wordpress_app/models/plant.dart";
import "package:wordpress_app/widgets/extentions.dart";

class DetailPageNew extends StatefulWidget {
  final int palntID;
  const DetailPageNew({super.key, required this.palntID});

  @override
  State<DetailPageNew> createState() => _DetailPageNewState();
}

class _DetailPageNewState extends State<DetailPageNew> {
  late Plant plant = Plant.plantList[widget.palntID];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // appBar
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                // Like Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      plant.isFavorated = !plant.isFavorated;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Constants.primaryColor.withValues(alpha: .2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      plant.isFavorated
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Constants.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // bodyFirstWidget
          Positioned(
            top: 80,
            right: 20,
            left: 20,
            child: Container(
              height: size.height * .8,
              width: size.width * .8,
              padding: EdgeInsets.all(20),
              child: Stack(
                children: [
                  // Image
                  Positioned(
                    top: 80,
                    left: 0,
                    child: SizedBox(
                      height: 300,
                      child: Image.asset(plant.imageURL),
                    ),
                  ),
                  // plantFeatures
                  Positioned(
                    top: 20,
                    right: 0,
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PlantFeaturess(
                            feature: "اندازه گیاه",
                            plantValue: plant.size,
                          ),
                          PlantFeaturess(
                            feature: "رطوبت هوا",
                            plantValue: plant.humidity.toString().farsiNumber,
                          ),
                          PlantFeaturess(
                            feature: "دمای نگهداری",
                            plantValue: plant.temperature.farsiNumber,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(top: 80, left: 30, right: 30),
              height: size.height * .5,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Constants.primaryColor.withValues(alpha: .5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            size: 30,
                            color: Constants.primaryColor,
                          ),
                          Text(
                            plant.rating.toString().farsiNumber,
                            style: TextStyle(
                              color: Constants.primaryColor,
                              fontFamily: "laleh",
                              fontSize: 23,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            plant.plantName,
                            style: TextStyle(
                              fontFamily: "laleh",
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Constants.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SizedBox(
                                height: 20,
                                child: Image.asset(
                                  "assets/images/PriceUnit-green.png",
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                plant.price.toString().farsiNumber,
                                style: TextStyle(
                                  fontFamily: "laleh",
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Constants.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    plant.decription,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: "sans",
                      fontSize: 16.5,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: size.width * .9,
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: InkResponse(
                onTap: () {
                  setState(() {
                    plant.isSelected = !plant.isSelected;
                  });
                  if (plant.isSelected == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        dismissDirection: DismissDirection.up,
                        duration: Duration(milliseconds: 900),
                        content: Text(
                          "گیاه ${plant.plantName} به سبد خرید اضافه شد",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontFamily: "yekan", fontSize: 16),
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'افزودن به سبد خرید',
                    style: TextStyle(
                      fontFamily: "laleh",
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Constants.primaryColor.withValues(alpha: .7),
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    
                  });
                  Navigator.pop(context);
                },
                child: plant.isSelected
                    ? Icon(Icons.check, color: Colors.white)
                    : Icon(Icons.shopping_cart, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlantFeaturess extends StatelessWidget {
  const PlantFeaturess({
    super.key,
    required this.feature,
    required this.plantValue,
  });

  final String feature;
  final String plantValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          feature,
          style: TextStyle(
            fontFamily: "laleh",
            fontWeight: FontWeight.bold,
            color: Constants.greyColor.withValues(alpha: .8),
            fontSize: 20,
          ),
        ),
        Text(
          plantValue,
          style: TextStyle(
            fontFamily: "laleh",
            fontSize: 20,
            color: Constants.primaryColor.withValues(alpha: .9),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}


import 'package:flutter/material.dart';
import "package:wordpress_app/constants/constants.dart";
import 'package:wordpress_app/models/plant.dart';
import 'package:wordpress_app/ui/product_details/detail_page.dart';
import 'package:wordpress_app/widgets/extentions.dart';
import 'package:page_transition/page_transition.dart';

class NewPlantWidget extends StatelessWidget {
    final List<Plant> plantList;
    final int index;

  const NewPlantWidget({
    super.key,
    required this.plantList,
    required this.index
  }) ;


  @override
  Widget build(BuildContext context) {

    // Size size=MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageTransition(
            type: PageTransitionType.bottomToTop,
            childBuilder: (context) =>
                DetailPageNew(palntID: plantList[index].plantId),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Constants.primaryColor.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(20),
        ),
        height: 80,
        padding: EdgeInsets.only(left: 10),
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset(
                    "assets/images/PriceUnit-green.png",
                  ),
                ),
                SizedBox(width: 3),
                Text(
                  plantList[index].price.toString().farsiNumber,
                  style: TextStyle(
                    fontFamily: "laleh",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Constants.primaryColor,
                  ),
                ),
              ],
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Constants.primaryColor.withValues(
                      alpha: .8,
                    ),
                    shape: BoxShape.circle,
                  ),
                  height: 60,
                  width: 60,
                ),
                Positioned(
                  bottom: -5,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 80,
                    child: Image.asset(
                      plantList[index].imageURL,
                    ),
                  ),
                ),
                Positioned(
                  right: 80,
                  bottom: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    // mainAxisAlignment: MainAxisAlignment.,
                    children: [
                      Text(
                        plantList[index].category,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "yekan",
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        plantList[index].plantName,
                        style: TextStyle(
                          color: Colors.black45,
                          fontFamily: "yekan",
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
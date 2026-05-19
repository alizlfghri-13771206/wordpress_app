import "package:flutter/material.dart";
import "package:wordpress_app/constants/constants.dart";
import "package:wordpress_app/models/plant.dart";
import "package:wordpress_app/widgets/plant_widget.dart";

class FavoritePage extends StatefulWidget {
  final List<Plant> favoritedPlants;
  const FavoritePage({super.key, required this.favoritedPlants});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.favoritedPlants.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0,horizontal: 12),
              child: ListView.builder(
                physics:BouncingScrollPhysics(),
                itemCount: widget.favoritedPlants.length,
                itemBuilder: (context, index) {
                  return NewPlantWidget(
                    plantList: widget.favoritedPlants,
                    index: index,
                  );
                },
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    child: Image.asset("assets/images/favorited.png"),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "ظاهراً به چیزی علاقه نداشتی :|",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Constants.primaryColor,
                      fontSize: 20,
                      fontFamily: "sans",
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

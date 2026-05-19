import "package:flutter/material.dart";
import "package:wordpress_app/constants/constants.dart";
import "package:wordpress_app/models/plant.dart";
import "package:wordpress_app/ui/product_details/detail_page.dart";
import "package:wordpress_app/widgets/plant_widget.dart";
import "package:page_transition/page_transition.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _plantTypes = [
    '| پیشنهادی |',
    '| آپارتمانی |',
    '| محل‌کار |',
    '| گل باغچه‌ایی |',
    '| گل سمی |',
  ];
  int selectedIndex = 0;

  final List<Plant> _plantList = Plant.plantList;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Center(
                  child: Container(
                    width: size.width * .9,
                    decoration: BoxDecoration(
                      color: Constants.primaryLightColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.mic, color: Constants.greyColor),
                          Expanded(
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextField(
                                showCursor: false,
                                style: TextStyle(fontFamily: "sans"),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(right: 5),
                                  hintText: "جستجو...",
                                  hintStyle: TextStyle(fontFamily: "sans"),
                                ),
                              ),
                            ),
                          ),
                          Icon(Icons.search, color: Constants.greyColor),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                height: 70,
                width: size.width,
                child: ListView.builder(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: _plantTypes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsetsGeometry.only(left: 8, right: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Text(
                          _plantTypes[index],
                          style: TextStyle(
                            letterSpacing: 0,
                            fontSize: 15,
                            color: selectedIndex == index
                                ? Constants.primaryColor
                                : Constants.greyColor,
                            fontFamily: "sans",
                            fontWeight: selectedIndex == index
                                ? FontWeight.bold
                                : FontWeight.w300,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: size.height * .30,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  itemCount: _plantList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            childBuilder: (context) =>
                                DetailPageNew(palntID: _plantList[index].plantId),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Constants.primaryColor.withAlpha(200),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 200,
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        child: Stack(
                          children: [
                            Positioned(
                              right: 15,
                              top: 10,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _plantList[index].isFavorated =
                                      !_plantList[index].isFavorated;
                                    });
          
                                  },
                                  icon: Icon(
                                    _plantList[index].isFavorated
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: Constants.primaryColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 50,
                              top: 50,
                              bottom: 50,
                              left: 50,
                              child: Image.asset(_plantList[index].imageURL),
                            ),
                            Positioned(
                              bottom: 15,
                              left: 20,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                width: 40,
                                child: Text(
                                  "\$${_plantList[index].price}",
                                  style: TextStyle(
                                    color: Constants.primaryColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 20,
                              bottom: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    _plantList[index].category,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontFamily: "yekan",
                                      fontSize: 14,
                                      // fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                  Text(
                                    _plantList[index].plantName,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontFamily: "yekan",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(top: 20, right: 20, bottom: 10),
                child: Text(
                  "گیاهان جدید",
                  style: TextStyle(
                    fontFamily: "laleh",
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18),
                height: size.height * .3,
                width: size.width,
                alignment: Alignment.center,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _plantList.length,
                  itemBuilder: (context, index) {
                    return NewPlantWidget(plantList: _plantList,index: index,);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


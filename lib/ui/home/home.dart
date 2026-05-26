import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:wordpress_app/constants/constants.dart";
import "package:wordpress_app/models/plant.dart";
import "package:wordpress_app/providers/post_provider.dart";
import "package:wordpress_app/providers/shop_provider.dart";
import "package:wordpress_app/ui/product_details/detail_page.dart";
import "package:wordpress_app/widgets/extentions.dart";
import "package:wordpress_app/widgets/plant_widget.dart";
import "package:page_transition/page_transition.dart";
import "package:intl/intl.dart" show NumberFormat;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _types = [
    '| برنامه نویسی |',
    '| مدیکال |',
    '| دسته بندی نشده |',
  ];
  int selectedIndex = 0;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((x) {
      final listOfShops = Provider.of<ShopProvider>(context, listen: false);
      listOfShops.getProductsFromProvider();
      final listOfPosts = Provider.of<PostProvider>(context, listen: false);
      listOfPosts.fetchPostsFromP();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // NumberFormat numberFormat = NumberFormat.decimalPattern('fa');
    return Consumer<ShopProvider>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
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
                      itemCount: _types.length,
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
                              _types[index],
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
                      itemCount: value.products.length,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      itemBuilder: (context, index) {
                        final product = value.products[index];
                        return GestureDetector(
                          onTap: () {},
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
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.favorite_border_outlined,
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
                                  // sssssssssssssssssssssssssssss
                                  child: CachedNetworkImage(
                                    imageUrl: product.images![0].src!,
                                    httpHeaders: {"Host": "alizolfaghari.ir"},
                                    placeholder: (context, url) =>
                                        SizedBox(
                                          height: 19,
                                          width: 19,
                                          child:CircularProgressIndicator(),),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
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
                                      // ssssssssssssssssssssssssssssssss
                                      product.price.toString().farsiNumber,
                                      style: TextStyle(
                                        color: Constants.primaryColor,
                                        fontSize: 12,
                                        fontFamily: 'yekan',
                                        fontWeight: .bold,
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
                                        // ssssssssssssssssssssssssssssssss
                                        product.categories![0].name.toString(),
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontFamily: "yekan",
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        // ssssssssssssssssssssssssssssssssssssss
                                        product.name.toString(),
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
                      "مطالب وبلاگ",
                      style: TextStyle(
                        fontFamily: "laleh",
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Consumer<PostProvider>(
                    builder: (context, value, child) {
                      if (value.isLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        height: size.height * .3,
                        width: size.width,
                        alignment: Alignment.center,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          // مطالب وبلاگ
                          itemCount: value.posts.length,
                          itemBuilder: (context, index) {
                            final post = value.posts[index];
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              padding: EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 20,
                              ),
                              decoration: BoxDecoration(
                                color: Constants.primaryColor.withValues(
                                  alpha: .7,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                post.title!,
                                textDirection: .rtl,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "yekan",
                                  fontSize: 20,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

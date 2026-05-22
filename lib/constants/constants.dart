import "package:flutter/material.dart";

class Constants {
  static final Color primaryColor = Color.fromARGB(255, 41, 110, 72);
  static final Color primaryLightColor = Color.fromARGB(50, 41, 110, 72);
  static final blackColor = Colors.black;
  static final greyColor = const Color.fromARGB(255, 107, 106, 106);

  static String titleOne = "گیاهان را بهتر از قبل درک کن";
  static String descriptionOne =
      "در مورد نگه داری گل و گیاهان میتوانی اطلاعات کسب کنی";
  static String titleTwo = "با گیاهان جدید آشنا شو";
  static String descriptionTwo =
      "رز مشکی یا گل رز دوست داری؟ اینجا میتونی پیداش کنی";
  static String titleThree = "با یک گل بهار نمیشود، گل بکار";
  static String descriptionThree =
      "هر گلی نیاز داشته باشید در این اپلیکیشن پیدا میکنید";
}

class WoocommereceInfo {
  // BASE URL WOOCOMMERECE
  static String baseUrl = 'http://45.81.17.183/wp-json/wc/v3/';

    // TOKEN URL 

  static String tokenUrl =
      "https://alizolfaghari.ir/wp-json/jwt-token/v1/token";

  // CONSUMER KEY AND SECRET
  static String consumerKey = 'ck_687489a3bc0496d4c8da6cf3e65da0a4bcf81b68';
  static String consumerSecret = 'cs_4ec95035b6137ba695c13bf44eee8928052309db';

  // API ENDPOINTS
  static String customersUrl = 'customers';
}

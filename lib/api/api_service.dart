import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import "package:http/http.dart" as http;
import 'package:dio/io.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/models/woocommerece/post_model.dart';
import 'package:wordpress_app/models/woocommerece/product_category_model.dart';
import 'package:wordpress_app/models/woocommerece/product_model.dart';
import 'package:wordpress_app/models/woocommerece/register_model.dart';
import "package:wordpress_app/models/woocommerece/login_model.dart";

class APIService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://45.81.17.183",
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
      headers: <String, dynamic>{
        "Host": "alizolfaghari.ir",
        "Content-Type": "application/json",
        "User-Agent": "PostmanRuntime/7.26.8",
      },
    ),
  );

  Future<bool> createCustomer(CustomerModel customer) async {
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    bool returnResponse = false;

    try {
      String token = base64Encode(
        utf8.encode(
          "${WoocommereceInfo.consumerKey}:${WoocommereceInfo.consumerSecret}",
        ),
      );

      print("شروع رک");

      final response = await dio.post(
        "/wp-json/wc/v3/customers/",
        data: customer.toJson(),
        options: Options(
          headers: <String, dynamic>{"Authorization": "Basic $token"},
        ),
      );

      print('بررسی request statusCode');

      if (response.statusCode == 201) {
        returnResponse = true;
        print("برگشت کد 201 و موفقیت آمیز بودن درخواست");
      }
    } on DioException catch (e) {
      print('توی 201 نرفت');

      if (e.response != null) {
        print("کد وضعیت: ${e.response?.statusCode}");
        print("دیتای ارسالی سرور: ${e.response?.data}");
        print("هدرهای برگشتی: ${e.response?.headers}");
      } else {
        print("خطای شبکه: ${e.message}");
      }
    }

    return returnResponse;
  }

  Future<LoginResponseModel> login(String username, String password) async {
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    late LoginResponseModel loginModel = LoginResponseModel();
    try {
      final response = await dio.post(
        "/wp-json/jwt-auth/v1/token",
        data: <String, dynamic>{"username": username, "password": password},
        options: Options(
          headers: <String, dynamic>{
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        loginModel = LoginResponseModel.fromJson(response.data, 200);
        print("برگشت کد 201 و موفقیت آمیز بودن درخواست");
      } else {
        loginModel = LoginResponseModel.fromJson(response.data, 403);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print("کد وضعیت: ${e.response?.statusCode}");
        print("دیتای ارسالی سرور: ${e.response?.data}");
        print("هدرهای برگشتی: ${e.response?.headers}");
      }
    }
    return loginModel;
  }

  Future<List<ProductModel>> getProducts() async {
    // dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    String token = base64Encode(
      utf8.encode(
        "${WoocommereceInfo.consumerKey}:${WoocommereceInfo.consumerSecret}",
      ),
    );

    List<ProductModel> listOfAllProducts = [];
    try {
      final response = await dio.get(
        "/wp-json/wc/v3/products/",
        options: Options(
          headers: <String, dynamic>{
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Basic $token",
          },
        ),
      );
      if (response.statusCode == 200) {
        listOfAllProducts = (response.data as List)
            .map((x) => ProductModel.fromJson(x))
            .toList();

        // listOfAllProducts.add(ProductModel.fromJson(response.data as List).map(x){})
      }
    } on DioException catch (e) {
      Exception(e.toString());
    }
    return listOfAllProducts;
  }

  Future<List<Post>> getPosts() async {
    // dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    List<Post> listOfAllPosts = [];

    try {
      final response = await dio.get(
        "/wp-json/wp/v2/posts",
        options: Options(
          headers: <String, dynamic>{
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        listOfAllPosts = (response.data as List)
            .map((x) => Post.fromJson(x))
            .toList();
      }
    } on DioException catch (e) {
      Exception(e.toString());
    }
    return listOfAllPosts;
  }

  Future<List<ProductCategoryModel>> getProductsCategory() async {
    final String productCategoryPath =
        "/wp-json/wc/v3/products/categories/?consumer_key=ck_687489a3bc0496d4c8da6cf3e65da0a4bcf81b68&consumer_secret=cs_4ec95035b6137ba695c13bf44eee8928052309db";
    List<ProductCategoryModel> listOfProductsCategory = [];
    try {
      final response = await Dio().get(
        "https://45.81.17.183$productCategoryPath",
        options: Options(
          headers: <String, dynamic>{
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        listOfProductsCategory = (response.data as List)
            .map((x) => ProductCategoryModel.fromJson(x))
            .toList();

        // listOfAllProducts.add(ProductModel.fromJson(response.data as List).map(x){})
      }
    } on DioException catch (e) {
      print("$e");
    }
    return listOfProductsCategory;
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import "package:http/http.dart" as http;
import 'package:dio/io.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/models/woocommerece/register_model.dart'; // ← این رو اضافه کن

class APIService {
  Future<bool> createCustomer(CustomerModel customer) async {
    bool returnResponse = false;
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
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

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
}

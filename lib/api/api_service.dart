import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/models/woocommerece/register_model.dart';

class APIService {
  Future<bool> createCustomer(CustomerModel customer) async {
    bool returnResponse = false;

    String authToken = base64.encode(
      utf8.encode(
        "${WoocommereceInfo.consumerKey}:${WoocommereceInfo.consumerSecret}",
      ),
    );
    try {
      var response = await Dio().post(
        WoocommereceInfo.baseUrl + WoocommereceInfo.customersUrl,
        data: customer.toJson(),
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Basic $authToken',
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );

      if (response.statusCode == 201) {
        returnResponse = true;
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        returnResponse = false;
      } else {
        returnResponse = false;
      }
    }
    return returnResponse;
  }
}

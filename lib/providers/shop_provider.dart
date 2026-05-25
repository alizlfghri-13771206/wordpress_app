import 'package:flutter/material.dart';
import 'package:wordpress_app/api/api_service.dart';
import 'package:wordpress_app/models/woocommerece/product_model.dart';

class ShopProvider extends ChangeNotifier {
  APIService? _apiServide = APIService();
  bool isLoading = false;

  List<ProductModel> _products = <ProductModel>[];
  List<ProductModel> get products => _products;

  Future<void> getProductsFromProvider() async {
    isLoading = true;
    notifyListeners();
    _products = await _apiServide!.getProducts();
    isLoading = false;
    notifyListeners();
  }

  void initilizeData() {
    _apiServide = APIService();
  }
}

import 'package:flutter/material.dart';
import 'package:wordpress_app/api/api_service.dart';
import 'package:wordpress_app/models/woocommerece/post_model.dart';

class PostProvider extends ChangeNotifier {
  final APIService _apiService = APIService();
  bool isLoading = false;
  List<Post> _posts = [];
  List<Post> get posts => _posts;

  Future<void> fetchPostsFromP() async {
    isLoading = true;
    notifyListeners();
    _posts = await _apiService.getPosts();
    isLoading = false;
    notifyListeners();
  }
}

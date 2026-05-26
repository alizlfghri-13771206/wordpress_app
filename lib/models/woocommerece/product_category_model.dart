class ProductCategoryModel {
  int? cateId;
  String? cateName;

  ProductCategoryModel({this.cateId, this.cateName});

  ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    cateId = json['id'];
    cateName = json['name'];
  }
}

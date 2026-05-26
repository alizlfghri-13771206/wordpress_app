class ProductModel {
  int? id;
  String? name, description, shortDescription, price, regularPrice;
  List<WooImages>? images;
  List<Categories>? categories;

  ProductModel({
    this.id,
    this.name,
    this.shortDescription,
    this.description,
    this.price,
    this.regularPrice,
    this.categories,
    this.images,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortDescription = json['short_description'];
    description = json['description'];
    price = json['price'];
    regularPrice = json['regular_price'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json["categories"].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <WooImages>[];
      json['images'].forEach((v) {
        images?.add(WooImages.fromJson(v));
      });
    }
  }
}

class WooImages {
  String? src;

  WooImages({this.src});

  WooImages.fromJson(Map<String, dynamic> json) {
    src = (json['src'] as String?)?.replaceFirst(
      "alizolfaghari.ir",
      "45.81.17.183",
    );
  }
}

class Categories {
  int? id;
  String? name;
  Categories({this.id, this.name});
  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data = {'id': id, 'name': name};
    return data;
  }
}

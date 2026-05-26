class Post {
  int? id;
  String? title, content;

  Post({this.id, this.title, this.content});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json["title"]["rendered"];
    content = json["content"]["rendered"];
  }
}

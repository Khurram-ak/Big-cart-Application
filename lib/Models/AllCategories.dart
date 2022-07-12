class AllCategories {
  String? message;
  int? statusCode;
  List<Category>? item;

  AllCategories({this.message, this.statusCode, this.item});

  AllCategories.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      item = <Category>[];
      json['data'].forEach((item) {
        item!.add(new Category.fromJson(item));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    if (this.item != null) {
      data['data'] = this.item!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? title;
  String? icon;
  String? color;

  Category({this.id, this.title, this.icon, this.color});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    icon = json['icon'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['icon'] = this.icon;
    data['color'] = this.color;
    return data;
  }
}

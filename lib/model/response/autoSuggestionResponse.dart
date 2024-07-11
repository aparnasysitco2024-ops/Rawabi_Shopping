class AutoSuggestionResponse {
  String? code;
  List<Words>? words;
  List<Categories>? categories;
  String? recentWords;

  AutoSuggestionResponse(
      {this.code, this.words, this.categories, this.recentWords});

  AutoSuggestionResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['words'] != null) {
      words = <Words>[];
      json['words'].forEach((v) {
        words!.add(new Words.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    recentWords = json['recent_words'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.words != null) {
      data['words'] = this.words!.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['recent_words'] = this.recentWords;
    return data;
  }
}

class Words {
  String? productId;
  String? product;
  String? image;

  Words({this.productId, this.product, this.image});

  Words.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    product = json['product'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product'] = this.product;
    data['image'] = this.image;
    return data;
  }
}

class Categories {
  String? categoryName;
  String? categoryId;

  Categories({this.categoryName, this.categoryId});

  Categories.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['category_id'] = this.categoryId;
    return data;
  }
}

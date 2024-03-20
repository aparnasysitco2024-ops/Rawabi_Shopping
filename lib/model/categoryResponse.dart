class CategoryResponse {
  String? code;
  String? message;
  Res? res;

  CategoryResponse({this.code, this.message, this.res});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    res = json['res'] != null ? Res.fromJson(json['res']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (res != null) {
      data['res'] = res!.toJson();
    }
    return data;
  }
}

class Res {
  List<Category>? category;

  Res({this.category});

  Res.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? catId;
  String? catName;
  String? catBanner;
  String? catIcon;
  List<SubCategory>? subCategory;

  Category(
      {this.catId,
        this.catName,
        this.catBanner,
        this.catIcon,
        this.subCategory});

  Category.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];
    catBanner = json['cat_banner'];
    catIcon = json['cat_icon'];
    if (json['sub_category'] != null) {
      subCategory = <SubCategory>[];
      json['sub_category'].forEach((v) {
        subCategory!.add(SubCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cat_id'] = catId;
    data['cat_name'] = catName;
    data['cat_banner'] = catBanner;
    data['cat_icon'] = catIcon;
    if (subCategory != null) {
      data['sub_category'] = subCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategory {
  String? subcatId;
  String? subcatName;
  String? subcatBanner;
  String? subcatIcon;

  SubCategory(
      {this.subcatId, this.subcatName, this.subcatBanner, this.subcatIcon});

  SubCategory.fromJson(Map<String, dynamic> json) {
    subcatId = json['subcat_id'];
    subcatName = json['subcat_name'];
    subcatBanner = json['subcat_banner'];
    subcatIcon = json['subcat_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subcat_id'] = subcatId;
    data['subcat_name'] = subcatName;
    data['subcat_banner'] = subcatBanner;
    data['subcat_icon'] = subcatIcon;
    return data;
  }
}

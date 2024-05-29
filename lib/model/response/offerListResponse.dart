import 'package:rawabi/model/response/products.dart';

class OfferListResponse {
  String? code;
  String? message;
  List<OfferCategory>? category;

  OfferListResponse({this.code, this.message, this.category});

  OfferListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['category'] != null) {
      category = <OfferCategory>[];
      json['category'].forEach((v) {
        category!.add(new OfferCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OfferCategory {
  String? catId;
  String? catName;
  String? catBanner;
  String? catIcon;
  List<Products>? products;

  OfferCategory(
      {this.catId, this.catName, this.catBanner, this.catIcon, this.products});

  OfferCategory.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];
    catBanner = json['cat_banner'];
    catIcon = json['cat_icon'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.catId;
    data['cat_name'] = this.catName;
    data['cat_banner'] = this.catBanner;
    data['cat_icon'] = this.catIcon;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


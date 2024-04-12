import 'package:rawabi/model/response/categoryResponse.dart';
import 'package:rawabi/model/response/products.dart';

class ProductsResponse {
  String? code;
  String? message;
  Res? res;

  ProductsResponse({this.code, this.res,this.message});

  ProductsResponse.fromJson(Map<String, dynamic> json) {
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
  Category? category;
  List<Products>? products;

  Res({this.category, this.products});

  Res.fromJson(Map<String, dynamic> json) {
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}






import 'products.dart';

class SearchResponse {
  String? code;

  List<Products>? products;

  SearchResponse({this.code,  this.products});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];

    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }
}

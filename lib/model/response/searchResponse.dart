

import '../response/products.dart';

class SearchResponse {
  String? code;

  Res? res;

  SearchResponse({this.code,  this.res});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    //if(res != null)
    res = json['res'] != null ? Res.fromJson(json['res']) : null;

  }
}
class Res{
  List<Products>? products;
  Res({this.products});
  Res.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }
}

class SearchBarcodeResponse{
  String? code;
  List<Products>? products;
  SearchBarcodeResponse({this.code,  this.products});
  SearchBarcodeResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }
}
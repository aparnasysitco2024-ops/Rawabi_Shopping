
import '../response/products.dart';

class WishListResponse {
  String? code;
  String? message;
  List<Products>? res;

  WishListResponse({this.code, this.message, this.res});

  WishListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['res'] != null) {
      res = <Products>[];
      json['res'].forEach((v) {
        res!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (res != null) {
      data['res'] = res!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


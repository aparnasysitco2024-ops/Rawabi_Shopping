import 'package:rawabi/model/response/categoryResponse.dart';
import 'package:rawabi/model/response/products.dart';

class ProductsResponse {
  String? code;
  String? message;
  Res? res;

  ProductsResponse({this.code, this.res, this.message});

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
  List<Brands>? brands;
  List<Subcategory>? subcategory;
  Price? price;

  Res({
    this.category,
    this.products,
    this.brands,
    this.subcategory,
    this.price});

  Res.fromJson(Map<String, dynamic> json) {
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands!.add(new Brands.fromJson(v));
      });
    }

    if (json['subcategory'] != null) {
      subcategory = <Subcategory>[];
      json['subcategory'].forEach((v) {
        subcategory!.add(new Subcategory.fromJson(v));
      });
    }
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (this.brands != null) {
      data['brands'] = this.brands!.map((v) => v.toJson()).toList();
    }
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory!.map((v) => v.toJson()).toList();
    }
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    return data;
  }
}

class Brands {
  String? name;
  String? id;

  Brands({this.name, this.id});

  Brands.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class Subcategory {
  String? subcatId;
  String? parentId;
  String? subcatName;
  String? subcatBanner;
  String? subcatIcon;

  Subcategory(
      {this.subcatId,
        this.parentId,
        this.subcatName,
        this.subcatBanner,
        this.subcatIcon});

  Subcategory.fromJson(Map<String, dynamic> json) {
    subcatId = json['subcat_id'];
    parentId = json['parent_id'];
    subcatName = json['subcat_name'];
    subcatBanner = json['subcat_banner'];
    subcatIcon = json['subcat_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subcat_id'] = this.subcatId;
    data['parent_id'] = this.parentId;
    data['subcat_name'] = this.subcatName;
    data['subcat_banner'] = this.subcatBanner;
    data['subcat_icon'] = this.subcatIcon;
    return data;
  }
}

class Price {
  String? max;
  String? min;

  Price({this.max, this.min});

  Price.fromJson(Map<String, dynamic> json) {
    max = json['max'];
    min = json['min'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['max'] = this.max;
    data['min'] = this.min;
    return data;
  }
}

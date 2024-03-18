class CartListResponse {
  String? code;
  String? message;
  List<Products>? products;

  CartListResponse({this.code, this.message, this.products});

  CartListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['res'] != null) {
      products = <Products>[];
      json['res'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (products != null) {
      data['res'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? cartId;
  String? productId;
  String? productName;
  String? productImage;
  String? itemPrice;
  String? quantity;
  String? subtotal;
  String? storeId;

  Products(
      {this.productId,
      this.productName,
      this.productImage,
      this.itemPrice,
      this.quantity,
      this.subtotal,
      this.storeId});

  Products.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    itemPrice = json['item_price'];
    quantity = json['quantity'];
    subtotal = json['subtotal'].toString();
    storeId = json['store_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_id'] = cartId;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['product_image'] = productImage;
    data['item_price'] = itemPrice;
    data['quantity'] = quantity;
    data['subtotal'] = subtotal;
    data['store_id'] = storeId;
    return data;
  }
}

class ProductDetailsResponse {
  String? code;
  String? message;
  ProductDetails? productDetails;

  ProductDetailsResponse({this.code, this.message, this.productDetails});

  ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    productDetails = json['res'] != null ? ProductDetails.fromJson(json['res']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (productDetails != null) {
      data['res'] = productDetails!.toJson();
    }
    return data;
  }
}

class ProductDetails {
  String? productId;
  String? productName;
  String? shortDesc;
  String? detailedDesc;
  String? sellingPrice;
  String? offerPrice;
  String? purchasePrice;
  String? stock;
  String? storeStock;
  String? productImage;

  ProductDetails(
      {this.productId,
        this.productName,
        this.shortDesc,
        this.detailedDesc,
        this.sellingPrice,
        this.offerPrice,
        this.purchasePrice,
        this.stock,
        this.storeStock,
        this.productImage});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    shortDesc = json['short_desc'];
    detailedDesc = json['detailed_desc'];
    sellingPrice = json['selling_price'];
    offerPrice = json['offer_price'];
    purchasePrice = json['purchase_price'];
    stock = json['stock'];
    storeStock = json['store_stock'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['short_desc'] = shortDesc;
    data['detailed_desc'] = detailedDesc;
    data['selling_price'] = sellingPrice;
    data['offer_price'] = offerPrice;
    data['purchase_price'] = purchasePrice;
    data['stock'] = stock;
    data['store_stock'] = storeStock;
    data['product_image'] = productImage;
    return data;
  }
}

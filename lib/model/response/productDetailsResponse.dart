class ProductDetailsResponse {
  String? code;
  String? message;
  ProductDetails? productDetails;

  ProductDetailsResponse({this.code, this.message, this.productDetails});

  ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    productDetails =
        json['res'] != null ? ProductDetails.fromJson(json['res']) : null;
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
  String? sellingPrice;
  String? offerPrice;
  String? storeId;
  String? sellerId;
  String? shortDesc;
  String? detailedDesc;
  String? purchasePrice;
  String? stock;
  String? storeStock;
  List<Features>? features;
  String? productImage;
  int? cartCount;
  int? wishlist;
  List<MultiImages>? multiImages;
  String? share_link;
  String? item_status;

  ProductDetails(
      {this.productId,
      this.productName,
      this.sellingPrice,
      this.offerPrice,
      this.storeId,
      this.sellerId,
      this.shortDesc,
      this.detailedDesc,
      this.purchasePrice,
      this.stock,
      this.storeStock,
      this.features,
      this.productImage,
      this.cartCount,
      this.wishlist,
      this.multiImages,
      this.share_link,
      this.item_status});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    sellingPrice = json['selling_price'];
    offerPrice = json['offer_price'];
    storeId = json['store_id'].toString();
    sellerId = json['seller_id'];
    shortDesc = json['short_desc'];
    detailedDesc = json['detailed_desc'];
    purchasePrice = json['purchase_price'];
    stock = json['stock'];
    storeStock = json['store_stock'];
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(Features.fromJson(v));
      });
    }
    productImage = json['product_image'];
    cartCount = json['cart_count'] ?? 0;
    wishlist = json['wishlist'] ?? 0;
    if (json['multi_images'] != null) {
      multiImages = <MultiImages>[];
      json['multi_images'].forEach((v) {
        multiImages!.add(new MultiImages.fromJson(v));
      });
    }
    share_link = json["share_link"];
    item_status = json['item_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['selling_price'] = sellingPrice;
    data['offer_price'] = offerPrice;
    data['store_id'] = storeId;
    data['seller_id'] = sellerId;
    data['short_desc'] = shortDesc;
    data['detailed_desc'] = detailedDesc;
    data['purchase_price'] = purchasePrice;
    data['stock'] = stock;
    data['store_stock'] = storeStock;
    if (features != null) {
      data['features'] = features!.map((v) => v.toJson()).toList();
    }
    data['product_image'] = productImage;
    data['cart_count'] = cartCount;
    data['wishlist'] = wishlist;
    if (this.multiImages != null) {
      data['multi_images'] = this.multiImages!.map((v) => v.toJson()).toList();
    }
    data["share_link"] = share_link;
    data['item_status'] = item_status;
    return data;
  }
}

class MultiImages {
  String? image;

  MultiImages({this.image});

  MultiImages.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}

class Features {
  String? featureTitle;
  String? feature;

  Features({this.featureTitle, this.feature});

  Features.fromJson(Map<String, dynamic> json) {
    featureTitle = json['feature_title'];
    feature = json['feature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feature_title'] = featureTitle;
    data['feature'] = feature;
    return data;
  }
}

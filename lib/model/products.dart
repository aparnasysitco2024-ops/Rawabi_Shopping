class Products {
  String? catId;
  String? catName;
  String? catBanner;
  String? catIcon;
  String? sellingPrice;
  String? offerPrice;
  String? storeId;
  String? sellerId;
  String? productId;
  String? productName;
  String? purchasePrice;
  String? stock;
  String? storeStock;
  String? productImage;
  int? cartCount;
  int? wishlist;

  Products(
      {this.catId,
      this.catName,
      this.catBanner,
      this.catIcon,
      this.sellingPrice,
      this.offerPrice,
      this.storeId,
      this.sellerId,
      this.productId,
      this.productName,
      this.purchasePrice,
      this.stock,
      this.storeStock,
      this.productImage,
      this.cartCount,
      this.wishlist});

  Products.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];
    catBanner = json['cat_banner'];
    catIcon = json['cat_icon'];
    sellingPrice = json['selling_price'];
    offerPrice = json['offer_price'];
    storeId = json['store_id'].toString();
    sellerId = json['seller_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    purchasePrice = json['purchase_price'];
    stock = json['stock'];
    storeStock = json['store_stock'];
    productImage = json['product_image'];
    cartCount = json['cart_count']??0;
    wishlist = json['wishlist']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cat_id'] = catId;
    data['cat_name'] = catName;
    data['cat_banner'] = catBanner;
    data['cat_icon'] = catIcon;
    data['selling_price'] = sellingPrice;
    data['offer_price'] = offerPrice;
    data['store_id'] = storeId;
    data['seller_id'] = sellerId;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['purchase_price'] = purchasePrice;
    data['stock'] = stock;
    data['store_stock'] = storeStock;
    data['product_image'] = productImage;
    data['cart_count'] = cartCount;
    data['wishlist']=wishlist;
    return data;
  }
}

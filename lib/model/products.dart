class Products {
  String? catId;
  String? catName;
  String? catBanner;
  String? catIcon;
  String? productId;
  String? productName;
  String? sellingPrice;
  String? offerPrice;
  String? purchasePrice;
  String? stock;
  String? storeStock;
  String? productImage;

  Products(
      {this.catId,
      this.catName,
      this.catBanner,
      this.catIcon,
      this.productId,
      this.productName,
      this.sellingPrice,
      this.offerPrice,
      this.purchasePrice,
      this.stock,
      this.storeStock,
      this.productImage});

  Products.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];
    catBanner = json['cat_banner'];
    catIcon = json['cat_icon'];
    productId = json['product_id'];
    productName = json['product_name'];
    sellingPrice = json['selling_price'];
    offerPrice = json['offer_price'];
    purchasePrice = json['purchase_price'];
    stock = json['stock'];
    storeStock = json['store_stock'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cat_id'] = catId;
    data['cat_name'] = catName;
    data['cat_banner'] = catBanner;
    data['cat_icon'] = catIcon;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['selling_price'] = sellingPrice;
    data['offer_price'] = offerPrice;
    data['purchase_price'] = purchasePrice;
    data['stock'] = stock;
    data['store_stock'] = storeStock;
    data['product_image'] = productImage;
    return data;
  }
}

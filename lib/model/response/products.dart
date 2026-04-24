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
  int? bestSeller;
  int? featured;
  int? organic;
  int? vegan;
  int? onlineExclusive;
  String? item_status;
  String? protags;

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
      this.wishlist,
      this.bestSeller,
      this.featured,
      this.organic,
      this.vegan,
      this.onlineExclusive,
      this.item_status,
      this.protags,
      });

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
    productName = json['product_name'] ?? "";
    purchasePrice = json['purchase_price'];
    stock = json['stock'];
    storeStock = json['store_stock'];
    productImage = json['product_image'];
    cartCount = json['cart_count'] ?? 0;
    wishlist = json['wishlist'] ?? 0;
    bestSeller = json['best_seller'] ?? 0;
    featured = json['featured'] ?? 0;
    organic = json['organic'] ?? 0;
    vegan = json['vegan'] ?? 0;
    onlineExclusive = json['online_exclusive'] ?? 0;
    item_status = json['item_status'];
    protags = json['pro_tags'];
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
    data['wishlist'] = wishlist;
    data['best_seller'] = this.bestSeller;
    data['featured'] = this.featured;
    data['organic'] = this.organic;
    data['vegan'] = this.vegan;
    data['online_exclusive'] = this.onlineExclusive;
    data['item_status'] = item_status;
    return data;
  }
}

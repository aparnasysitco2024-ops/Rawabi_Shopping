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
        this.productImage});

  Products.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];
    catBanner = json['cat_banner'];
    catIcon = json['cat_icon'];
    sellingPrice = json['selling_price'];
    offerPrice = json['offer_price'];
    storeId = json['store_id'];
    sellerId = json['seller_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    purchasePrice = json['purchase_price'];
    stock = json['stock'];
    storeStock = json['store_stock'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.catId;
    data['cat_name'] = this.catName;
    data['cat_banner'] = this.catBanner;
    data['cat_icon'] = this.catIcon;
    data['selling_price'] = this.sellingPrice;
    data['offer_price'] = this.offerPrice;
    data['store_id'] = this.storeId;
    data['seller_id'] = this.sellerId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['purchase_price'] = this.purchasePrice;
    data['stock'] = this.stock;
    data['store_stock'] = this.storeStock;
    data['product_image'] = this.productImage;
    return data;
  }
}

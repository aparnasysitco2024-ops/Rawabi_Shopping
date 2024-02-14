class HomeResponse {
  String? code;
  String? message;
  Res? res;

  HomeResponse({this.code, this.message, this.res});

  HomeResponse.fromJson(Map<String, dynamic> json) {
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
  List<Category>? category;
  List<Slider>? slider;
  List<ItemGroup>? itemGroup;
  List<Null>? bottomBanner;

  Res({this.category, this.slider, this.itemGroup, this.bottomBanner});

  Res.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
    if (json['slider'] != null) {
      slider = <Slider>[];
      json['slider'].forEach((v) {
        slider!.add(Slider.fromJson(v));
      });
    }
    if (json['item_group'] != null) {
      itemGroup = <ItemGroup>[];
      json['item_group'].forEach((v) {
        itemGroup!.add(ItemGroup.fromJson(v));
      });
    }
    // if (json['bottom_banner'] != null) {
    //   bottomBanner = <Null>[];
    //   json['bottom_banner'].forEach((v) {
    //     bottomBanner!.add(Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    if (slider != null) {
      data['slider'] = slider!.map((v) => v.toJson()).toList();
    }
    if (itemGroup != null) {
      data['item_group'] = itemGroup!.map((v) => v.toJson()).toList();
    }
    // if (bottomBanner != null) {
    //   data['bottom_banner'] =
    //       bottomBanner!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Category {
  String? catId;
  String? catName;
  String? catBanner;
  String? catIcon;

  Category({this.catId, this.catName, this.catBanner, this.catIcon});

  Category.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];
    catBanner = json['cat_banner'];
    catIcon = json['cat_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cat_id'] = catId;
    data['cat_name'] = catName;
    data['cat_banner'] = catBanner;
    data['cat_icon'] = catIcon;
    return data;
  }
}

class Slider {
  String? bannerId;
  String? bannerName;
  String? linkType;
  String? bannerPoint;
  String? bannerImage;

  Slider(
      {this.bannerId,
        this.bannerName,
        this.linkType,
        this.bannerPoint,
        this.bannerImage});

  Slider.fromJson(Map<String, dynamic> json) {
    bannerId = json['banner_id'];
    bannerName = json['banner_name'];
    linkType = json['link_type'];
    bannerPoint = json['banner_point'];
    bannerImage = json['banner_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['banner_id'] = bannerId;
    data['banner_name'] = bannerName;
    data['link_type'] = linkType;
    data['banner_point'] = bannerPoint;
    data['banner_image'] = bannerImage;
    return data;
  }
}

class ItemGroup {
  String? grpId;
  String? grpName;
  String? grpType;
  String? grpDesign;
  String? grpStartDate;
  String? grpEndDate;
  List<GrpItems>? grpItems;
  List<Category>? grpCategory;
  String? grpImage;

  ItemGroup(
      {this.grpId,
        this.grpName,
        this.grpType,
        this.grpDesign,
        this.grpStartDate,
        this.grpEndDate,
        this.grpItems,
        this.grpCategory,
        this.grpImage});

  ItemGroup.fromJson(Map<String, dynamic> json) {
    grpId = json['grp_id'];
    grpName = json['grp_name'];
    grpType = json['grp_type'];
    grpDesign = json['grp_design'];
    grpStartDate = json['grp_start_date'];
    grpEndDate = json['grp_end_date'];
    if (json['grp_items'] != null) {
      grpItems = <GrpItems>[];
      json['grp_items'].forEach((v) {
        grpItems!.add(GrpItems.fromJson(v));
      });
    }
    if (json['grp_category'] != null) {
      grpCategory = <Category>[];
      json['grp_category'].forEach((v) {
        grpCategory!.add(Category.fromJson(v));
      });
    }
    grpImage = json['grp_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grp_id'] = grpId;
    data['grp_name'] = grpName;
    data['grp_type'] = grpType;
    data['grp_design'] = grpDesign;
    data['grp_start_date'] = grpStartDate;
    data['grp_end_date'] = grpEndDate;
    if (grpItems != null) {
      data['grp_items'] = grpItems!.map((v) => v.toJson()).toList();
    }
    if (grpCategory != null) {
      data['grp_category'] = grpCategory!.map((v) => v.toJson()).toList();
    }
    data['grp_image'] = grpImage;
    return data;
  }
}

class GrpItems {
  String? productId;
  String? productName;
  String? sellingPrice;
  String? offerPrice;
  String? purchasePrice;
  String? stock;
  String? storeStock;
  String? productImage;

  GrpItems(
      {this.productId,
        this.productName,
        this.sellingPrice,
        this.offerPrice,
        this.purchasePrice,
        this.stock,
        this.storeStock,
        this.productImage});

  GrpItems.fromJson(Map<String, dynamic> json) {
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

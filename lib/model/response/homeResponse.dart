import 'package:rawabi/model/response/products.dart';

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
  String? banner_type;
  String? cat;
  String? subcat;
  String? subsubcat;

  Slider(
      {this.bannerId,
      this.bannerName,
      this.linkType,
      this.bannerPoint,
      this.bannerImage,
      this.banner_type,
      this.cat,
      this.subcat,
      this.subsubcat});

  Slider.fromJson(Map<String, dynamic> json) {
    bannerId = json['banner_id'];
    bannerName = json['banner_name'];
    linkType = json['link_type'];
    bannerPoint = json['banner_point'];
    bannerImage = json['banner_image'];
    banner_type = json['banner_type'];
    cat = json['cat'];
    subcat = json['subcat'];
    subsubcat = json['subsubcat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['banner_id'] = bannerId;
    data['banner_name'] = bannerName;
    data['link_type'] = linkType;
    data['banner_point'] = bannerPoint;
    data['banner_image'] = bannerImage;
    data['banner_type'] = banner_type;
    data['cat'] = cat;
    data['subcat'] = subcat;
    data['subsubcat'] = subsubcat;
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
  List<Products>? grpItems;
  List<Category>? grpCategory;
  String? grpImage;
  List<GrpImages>? grpImages;

  ItemGroup(
      {this.grpId,
      this.grpName,
      this.grpType,
      this.grpDesign,
      this.grpStartDate,
      this.grpEndDate,
      this.grpItems,
      this.grpCategory,
      this.grpImage,
      this.grpImages});

  ItemGroup.fromJson(Map<String, dynamic> json) {
    grpId = json['grp_id'];
    grpName = json['grp_name'];
    grpType = json['grp_type'];
    grpDesign = json['grp_design'];
    grpStartDate = json['grp_start_date'];
    grpEndDate = json['grp_end_date'];
    if (json['grp_items'] != null) {
      grpItems = <Products>[];
      json['grp_items'].forEach((v) {
        grpItems!.add(Products.fromJson(v));
      });
    }
    if (json['grp_category'] != null) {
      grpCategory = <Category>[];
      json['grp_category'].forEach((v) {
        grpCategory!.add(Category.fromJson(v));
      });
    }
    grpImage = json['grp_image'];
    if (json['grp_images'] != null) {
      grpImages = <GrpImages>[];
      json['grp_images'].forEach((v) {
        grpImages!.add(GrpImages.fromJson(v));
      });
    }
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
    if (grpImages != null) {
      data['grp_images'] = grpImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GrpImages {
  String? image;
  String? linkType;
  String? bannerPoint;
  String? cat;
  String? subcat;
  String? subsubcat;

  GrpImages(
      {this.image,
      this.linkType,
      this.bannerPoint,
      this.cat,
      this.subcat,
      this.subsubcat});

  GrpImages.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    linkType = json['link_type'];
    bannerPoint = json['banner_point'];
    cat = json['cat'];
    subcat = json['subcat'];
    subsubcat = json['subsubcat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['link_type'] = this.linkType;
    data['banner_point'] = this.bannerPoint;
    data['cat'] = cat;
    data['subcat'] = subcat;
    data['subsubcat'] = subsubcat;
    return data;
  }
}

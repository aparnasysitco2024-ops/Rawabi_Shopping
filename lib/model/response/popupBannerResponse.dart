class PopupBannerResponse {
  String? code;
  List<PopUpBanners>? popUpBanners;
  List<Update>? update;

  PopupBannerResponse({this.code, this.popUpBanners, this.update});

  PopupBannerResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['res'] != null) {
      popUpBanners = <PopUpBanners>[];
      json['res'].forEach((v) {
        popUpBanners!.add(new PopUpBanners.fromJson(v));
      });
    }
    if (json['update'] != null) {
      update = <Update>[];
      json['update'].forEach((v) {
        update!.add(new Update.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.popUpBanners != null) {
      data['res'] = this.popUpBanners!.map((v) => v.toJson()).toList();
    }
    if (this.update != null) {
      data['update'] = this.update!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PopUpBanners {
  String? bannerId;
  String? bannerName;
  String? linkType;
  String? bannerPoint;
  String? bannerType;
  String? bannerImage;
  String? cat;
  String? subcat;
  String? subsubcat;

  PopUpBanners(
      {this.bannerId,
        this.bannerName,
        this.linkType,
        this.bannerPoint,
        this.bannerType,
        this.bannerImage,
        this.cat,
        this.subcat,
        this.subsubcat});

  PopUpBanners.fromJson(Map<String, dynamic> json) {
    bannerId = json['banner_id'];
    bannerName = json['banner_name'];
    linkType = json['link_type'];
    bannerPoint = json['banner_point'];
    bannerType = json['banner_type'];
    bannerImage = json['banner_image'];
    cat = json['cat'];
    subcat = json['subcat'];
    subsubcat = json['subsubcat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner_id'] = this.bannerId;
    data['banner_name'] = this.bannerName;
    data['link_type'] = this.linkType;
    data['banner_point'] = this.bannerPoint;
    data['banner_type'] = this.bannerType;
    data['banner_image'] = this.bannerImage;
    data['cat'] = cat;
    data['subcat'] = subcat;
    data['subsubcat'] = subsubcat;
    return data;
  }
}

class Update {
  String? version;
  String? forceUpdate;

  Update({this.version, this.forceUpdate});

  Update.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    forceUpdate = json['force_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this.version;
    data['force_update'] = this.forceUpdate;
    return data;
  }
}

class PopupBannerResponse {
  String? code;
  List<PopUpBanners>? popUpBanners;

  PopupBannerResponse({this.code, this.popUpBanners});

  PopupBannerResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['res'] != null) {
      popUpBanners = <PopUpBanners>[];
      json['res'].forEach((v) {
        popUpBanners!.add(new PopUpBanners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.popUpBanners != null) {
      data['res'] = this.popUpBanners!.map((v) => v.toJson()).toList();
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

  PopUpBanners(
      {this.bannerId,
        this.bannerName,
        this.linkType,
        this.bannerPoint,
        this.bannerType,
        this.bannerImage});

  PopUpBanners.fromJson(Map<String, dynamic> json) {
    bannerId = json['banner_id'];
    bannerName = json['banner_name'];
    linkType = json['link_type'];
    bannerPoint = json['banner_point'];
    bannerType = json['banner_type'];
    bannerImage = json['banner_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner_id'] = this.bannerId;
    data['banner_name'] = this.bannerName;
    data['link_type'] = this.linkType;
    data['banner_point'] = this.bannerPoint;
    data['banner_type'] = this.bannerType;
    data['banner_image'] = this.bannerImage;
    return data;
  }
}

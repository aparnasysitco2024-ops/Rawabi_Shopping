class StoreResponse {
  String? code;
  String? message;
  List<StoreList>? res;

  StoreResponse({this.code, this.message, this.res});

  StoreResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['res'] != null) {
      res = <StoreList>[];
      json['res'].forEach((v) {
        res!.add(StoreList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (res != null) {
      data['res'] = res!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoreList {
  String? storeId;
  String? storeName;
  String? latitude;
  String? longitude;
  String? phone;
  String? address;

  StoreList(
      {this.storeId,
      this.storeName,
      this.latitude,
      this.longitude,
      this.phone,
      this.address});

  StoreList.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    storeName = json['store_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['phone'] = phone;
    data['address'] = address;
    return data;
  }
}

class AddressListResponse {
  String? code;
  String? message;
  List<AddressList>? res;

  AddressListResponse({this.code, this.message, this.res});

  AddressListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['res'] != null) {
      res = <AddressList>[];
      json['res'].forEach((v) {
        res!.add(AddressList.fromJson(v));
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

class AddressList {
  String? addressId;
  String? addressName;
  String? zone;
  String? phone;
  String? addressType;
  String? address;
  String? houseBuilding;
  String? apartmentOffice;
  String? floor;
  String? addressInstruction;
  String? defaultAddress;
  String? lat;
  String? long;

  AddressList(
      {this.addressId,
      this.addressName,
      this.zone,
      this.phone,
      this.addressType,
      this.address,
      this.houseBuilding,
      this.apartmentOffice,
      this.floor,
      this.addressInstruction,
      this.defaultAddress,
      this.lat,
      this.long});

  AddressList.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    addressName = json['address_name'];
    zone = json['zone'];
    phone = json['phone'];
    addressType = json['address_type'];
    address = json['address'];
    houseBuilding = json['house_building'];
    apartmentOffice = json['apartment_office'];
    floor = json['floor'];
    addressInstruction = json['address_instruction'];
    defaultAddress = json['default'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_id'] = addressId;
    data['address_name'] = addressName;
    data['zone'] = zone;
    data['phone'] = phone;
    data['address_type'] = addressType;
    data['address'] = address;
    data['house_building'] = houseBuilding;
    data['apartment_office'] = apartmentOffice;
    data['floor'] = floor;
    data['address_instruction'] = addressInstruction;
    data['default'] = defaultAddress;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}

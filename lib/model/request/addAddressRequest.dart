class AddAddressRequest {
  String? addressName;
  String? zone;
  String? phone;
  String? type;
  String? address;
  String? houseBuilding;
  String? apartmentOffice;
  String? floor;
  String? addressInstruction;

  AddAddressRequest(
      {this.addressName,
        this.zone,
        this.phone,
        this.type,
        this.address,
        this.houseBuilding,
        this.apartmentOffice,
        this.floor,
        this.addressInstruction});

  AddAddressRequest.fromJson(Map<String, dynamic> json) {
    addressName = json['address_name'];
    zone = json['zone'];
    phone = json['phone'];
    type = json['type'];
    address = json['address'];
    houseBuilding = json['house_building'];
    apartmentOffice = json['apartment_office'];
    floor = json['floor'];
    addressInstruction = json['address_instruction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_name'] = addressName;
    data['zone'] = zone;
    data['phone'] = phone;
    data['type'] = type;
    data['address'] = address;
    data['house_building'] = houseBuilding;
    data['apartment_office'] = apartmentOffice;
    data['floor'] = floor;
    data['address_instruction'] = addressInstruction;
    return data;
  }
}

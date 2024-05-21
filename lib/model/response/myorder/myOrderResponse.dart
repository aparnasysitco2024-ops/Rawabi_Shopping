import 'items.dart';

class MyOrderResponse {
  String? code;
  String? message;
  Res? res;

  MyOrderResponse({this.code, this.message, this.res});

  MyOrderResponse.fromJson(Map<String, dynamic> json) {
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
  List<Orders>? orders;

  Res({this.orders});

  Res.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  String? orderid;
  String? refno;
  String? status;
  String? date;
  String? addressId;
  String? addressName;
  String? zone;
  String? latlng;
  String? phone;
  String? addressType;
  String? address;
  String? houseBuilding;
  String? apartmentOffice;
  String? floor;
  String? addressInstruction;
  String? subtotal;
  String? discount;
  String? payable;
  List<Items>? items;

  Orders(
      {this.orderid,
        this.refno,
        this.status,
        this.date,
        this.addressId,
        this.addressName,
        this.zone,
        this.latlng,
        this.phone,
        this.addressType,
        this.address,
        this.houseBuilding,
        this.apartmentOffice,
        this.floor,
        this.addressInstruction,
        this.subtotal,
        this.discount,
        this.payable,
        this.items});

  Orders.fromJson(Map<String, dynamic> json) {
    orderid = json['orderid'];
    refno = json['refno'];
    status = json['status'];
    date = json['date'];
    addressId = json['address_id'];
    addressName = json['address_name'];
    zone = json['zone'];
    latlng = json['lat_long'];
    phone = json['phone'];
    addressType = json['address_type'];
    address = json['address'];
    houseBuilding = json['house_building'];
    apartmentOffice = json['apartment_office'];
    floor = json['floor'];
    addressInstruction = json['address_instruction'];
    subtotal = json['subtotal'];
    discount = json['discount'];
    payable = json['payable'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderid'] = orderid;
    data['refno'] = refno;
    data['status'] = status;
    data['date'] = date;
    data['address_id'] = addressId;
    data['address_name'] = addressName;
    data['zone'] = zone;
    data['lat_long']=latlng;
    data['phone'] = phone;
    data['address_type'] = addressType;
    data['address'] = address;
    data['house_building'] = houseBuilding;
    data['apartment_office'] = apartmentOffice;
    data['floor'] = floor;
    data['address_instruction'] = addressInstruction;
    data['subtotal'] = subtotal;
    data['discount'] = discount;
    data['payable'] = payable;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


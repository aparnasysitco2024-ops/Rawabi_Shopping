class MyOrderResponse {
  String? code;
  String? message;
  List<MyOrder>? myOrder;

  MyOrderResponse({this.code, this.message, this.myOrder});

  MyOrderResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['res'] != null) {
      myOrder = <MyOrder>[];
      json['res'].forEach((v) {
        myOrder!.add(MyOrder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (myOrder != null) {
      data['res'] = myOrder!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyOrder {
  String? refno;
  String? status;
  String? date;
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
  String? subtotal;
  String? discount;
  String? payable;
  List<Items>? items;

  MyOrder(
      {this.refno,
        this.status,
        this.date,
        this.addressId,
        this.addressName,
        this.zone,
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

  MyOrder.fromJson(Map<String, dynamic> json) {
    refno = json['refno'];
    status = json['status'];
    date = json['date'];
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
    data['refno'] = refno;
    data['status'] = status;
    data['date'] = date;
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
    data['subtotal'] = subtotal;
    data['discount'] = discount;
    data['payable'] = payable;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? itemName;
  String? itemPrice;
  String? itemQty;
  String? subtotal;

  Items({this.itemName, this.itemPrice, this.itemQty, this.subtotal});

  Items.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    itemPrice = json['item_price'];
    itemQty = json['item_qty'];
    subtotal = json['subtotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_name'] = itemName;
    data['item_price'] = itemPrice;
    data['item_qty'] = itemQty;
    data['subtotal'] = subtotal;
    return data;
  }
}

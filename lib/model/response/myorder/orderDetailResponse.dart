import 'package:rawabi/model/response/myorder/myOrderResponse.dart';

class OrderDetailResponse {
  String? code;
  String? message;
  List<Orders>? res;

  OrderDetailResponse({this.code, this.message, this.res});

  OrderDetailResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['res'] != null) {
      res = <Orders>[];
      json['res'].forEach((v) {
        res!.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.res != null) {
      data['res'] = this.res!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class Res {
//   String? orderid;
//   String? refno;
//   String? status;
//   String? date;
//   String? addressId;
//   String? addressName;
//   String? zone;
//   String? phone;
//   String? addressType;
//   String? address;
//   String? houseBuilding;
//   String? apartmentOffice;
//   String? floor;
//   String? addressInstruction;
//   String? subtotal;
//   String? discount;
//   String? payable;
//   List<Items>? items;
//
//   Res(
//       {this.orderid,
//       this.refno,
//       this.status,
//       this.date,
//       this.addressId,
//       this.addressName,
//       this.zone,
//       this.phone,
//       this.addressType,
//       this.address,
//       this.houseBuilding,
//       this.apartmentOffice,
//       this.floor,
//       this.addressInstruction,
//       this.subtotal,
//       this.discount,
//       this.payable,
//       this.items});
//
//   Res.fromJson(Map<String, dynamic> json) {
//     orderid = json['orderid'];
//     refno = json['refno'];
//     status = json['status'];
//     date = json['date'];
//     addressId = json['address_id'];
//     addressName = json['address_name'];
//     zone = json['zone'];
//     phone = json['phone'];
//     addressType = json['address_type'];
//     address = json['address'];
//     houseBuilding = json['house_building'];
//     apartmentOffice = json['apartment_office'];
//     floor = json['floor'];
//     addressInstruction = json['address_instruction'];
//     subtotal = json['subtotal'];
//     discount = json['discount'];
//     payable = json['payable'];
//     if (json['items'] != null) {
//       items = <Items>[];
//       json['items'].forEach((v) {
//         items!.add(new Items.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['orderid'] = this.orderid;
//     data['refno'] = this.refno;
//     data['status'] = this.status;
//     data['date'] = this.date;
//     data['address_id'] = this.addressId;
//     data['address_name'] = this.addressName;
//     data['zone'] = this.zone;
//     data['phone'] = this.phone;
//     data['address_type'] = this.addressType;
//     data['address'] = this.address;
//     data['house_building'] = this.houseBuilding;
//     data['apartment_office'] = this.apartmentOffice;
//     data['floor'] = this.floor;
//     data['address_instruction'] = this.addressInstruction;
//     data['subtotal'] = this.subtotal;
//     data['discount'] = this.discount;
//     data['payable'] = this.payable;
//     if (this.items != null) {
//       data['items'] = this.items!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }



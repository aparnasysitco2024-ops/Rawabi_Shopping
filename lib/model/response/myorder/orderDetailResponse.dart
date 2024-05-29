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




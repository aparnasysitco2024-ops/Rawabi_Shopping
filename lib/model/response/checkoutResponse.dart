class CheckoutResponse {
  String? code;
  String? orderId;
  String? purchaseCode;
  String? message;

  CheckoutResponse({this.code, this.orderId, this.purchaseCode, this.message});

  CheckoutResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    orderId = json['order_id'];
    purchaseCode = json['purchase_code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['order_id'] = this.orderId;
    data['purchase_code'] = this.purchaseCode;
    data['message'] = this.message;
    return data;
  }
}

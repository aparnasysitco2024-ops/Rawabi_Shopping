class OrderStatusResponse {
  String? code;
  String? message;
  List<Status>? status;

  OrderStatusResponse({this.code, this.message, this.status});

  OrderStatusResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['status'] != null) {
      status = <Status>[];
      json['status'].forEach((v) {
        status!.add(new Status.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.status != null) {
      data['status'] = this.status!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Status {
  String? orderPlaced;
  String? orderTime;
  String? processing;
  String? processTime;
  String? delivering;
  String? deliverTime;
  String? delivered;
  String? deliveryTime;

  Status(
      {this.orderPlaced,
        this.orderTime,
        this.processing,
        this.processTime,
        this.delivering,
        this.deliverTime,
        this.delivered,
        this.deliveryTime});

  Status.fromJson(Map<String, dynamic> json) {
    orderPlaced = json['order_placed'];
    orderTime = json['order_time'];
    processing = json['processing'];
    processTime = json['process_time'];
    delivering = json['delivering'];
    deliverTime = json['deliver_time'];
    delivered = json['delivered'];
    deliveryTime = json['delivery_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_placed'] = this.orderPlaced;
    data['order_time'] = this.orderTime;
    data['processing'] = this.processing;
    data['process_time'] = this.processTime;
    data['delivering'] = this.delivering;
    data['deliver_time'] = this.deliverTime;
    data['delivered'] = this.delivered;
    data['delivery_time'] = this.deliveryTime;
    return data;
  }
}

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
  String? order_type;
  String? order_delivery_type;
  String? store_name;

  Status(
      {this.orderPlaced,
      this.orderTime,
      this.processing,
      this.processTime,
      this.delivering,
      this.deliverTime,
      this.delivered,
      this.deliveryTime,
      this.order_type,
      this.order_delivery_type,
      this.store_name});

  Status.fromJson(Map<String, dynamic> json) {
    orderPlaced = json['order_placed'];
    orderTime = json['order_time'];
    processing = json['processing'];
    processTime = json['process_time'];
    delivering = json['delivering'];
    deliverTime = json['deliver_time'];
    delivered = json['delivered'];
    deliveryTime = json['delivery_time'];
    order_type = json['order_type'];
    order_delivery_type = json['order_delivery_type'];
    store_name = json['store_name'];
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

    data['order_type'] = this.order_type;
    data['order_delivery_type'] = this.order_delivery_type;
    data['store_name'] = this.store_name;
    return data;
  }
}

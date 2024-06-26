class Items {
  String? itemName;
  String? itemPrice;
  String? itemQty;
  String? subtotal;
  String? deliveredBy;
  String? deliveryDays;
  String? itemImage;
  String? delete;
  String? alter;

  Items(
      {this.itemName,
      this.itemPrice,
      this.itemQty,
      this.subtotal,
      this.deliveredBy,
      this.deliveryDays,
      this.itemImage,
      this.delete,
      this.alter});

  Items.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    itemPrice = json['item_price'];
    itemQty = json['item_qty'];
    subtotal = json['subtotal'];
    deliveredBy = json['delivered_by'];
    deliveryDays = json['delivery_days'];
    itemImage = json['itemImage'];
    delete = json['delete'];
    alter = json['alter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_name'] = this.itemName;
    data['item_price'] = this.itemPrice;
    data['item_qty'] = this.itemQty;
    data['subtotal'] = this.subtotal;
    data['delivered_by'] = this.deliveredBy;
    data['delivery_days'] = this.deliveryDays;
    data['itemImage'] = this.itemImage;
    data['delete'] = delete;
    data['alter'] = alter;
    return data;
  }
}

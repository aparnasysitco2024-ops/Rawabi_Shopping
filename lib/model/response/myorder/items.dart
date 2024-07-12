class Items {
  String? itemId;
  String? itemName;
  String? itemPrice;
  String? itemQty;
  String? subtotal;
  String? deliveredBy;
  String? deliveryDays;
  String? itemImage;
  String? delete;
  String? alter;
  String? detailId;
  int? returnEligible;

  Items({
    this.itemId,
    this.itemName,
    this.itemPrice,
    this.itemQty,
    this.subtotal,
    this.deliveredBy,
    this.deliveryDays,
    this.itemImage,
    this.delete,
    this.alter,
    this.detailId,
    this.returnEligible,
  });

  Items.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    itemName = json['item_name'];
    itemPrice = json['item_price'];
    itemQty = json['item_qty'];
    subtotal = json['subtotal'];
    deliveredBy = json['delivered_by'];
    deliveryDays = json['delivery_days'];
    itemImage = json['item_image'];
    delete = json['delete'];
    alter = json['alter'];
    detailId = json['detail_id'];
    returnEligible = json['return_eligible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['item_name'] = this.itemName;
    data['item_price'] = this.itemPrice;
    data['item_qty'] = this.itemQty;
    data['subtotal'] = this.subtotal;
    data['delivered_by'] = this.deliveredBy;
    data['delivery_days'] = this.deliveryDays;
    data['itemImage'] = this.itemImage;
    data['delete'] = delete;
    data['alter'] = alter;
    data['detail_id'] = this.detailId;
    data['return_eligible'] = this.returnEligible;
    return data;
  }
}

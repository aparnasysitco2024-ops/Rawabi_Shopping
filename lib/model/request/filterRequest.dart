class FilterRequest {
  String? brand;
  String? min;
  String? price;
  String? variables;
  String? catid;
  String? subcatid;
  String? subSubcatid;
  String? subSubSubcatid;
  String? selectedTopCategoryID;
  String? page;
  String? sort;

  FilterRequest(
      {this.brand,
      this.min,
      this.price,
      this.variables,
      this.catid,
      this.subcatid,
      this.subSubcatid,
      this.subSubSubcatid,
      this.selectedTopCategoryID,
      this.page,
      this.sort});

  FilterRequest.fromJson(Map<String, dynamic> json) {
    brand = json['brand'];
    min = json['min'];
    price = json['price'];
    variables = json['variables'];
    catid = json['catid'];
    subcatid = json['subcatid'];
    subSubcatid = json['sub-subcatid'];
    subSubSubcatid = json['sub-sub-subcatid'];
    page = json['page'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand'] = this.brand;
    data['min'] = this.min;
    data['price'] = this.price;
    data['variables'] = this.variables;
    data['catid'] = this.catid;
    data['subcatid'] = this.subcatid;
    data['sub-subcatid'] = this.subSubcatid;
    data['sub-sub-subcatid'] = this.subSubSubcatid;
    data['page'] = this.page;
    data['sort'] = this.sort;
    return data;
  }
}

import 'package:rawabi/model/response/products.dart';

class ItemGroupDetailsResponse {
  String? code;
  String? message;
  List<ItemGroup>? itemGroup;

  ItemGroupDetailsResponse({this.code, this.message, this.itemGroup});

  ItemGroupDetailsResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['item_group'] != null) {
      itemGroup = <ItemGroup>[];
      json['item_group'].forEach((v) {
        itemGroup!.add(new ItemGroup.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.itemGroup != null) {
      data['item_group'] = this.itemGroup!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemGroup {
  String? grpId;
  String? grpName;
  String? grpType;
  String? grpDesign;
  String? grpStartDate;
  String? grpEndDate;
  String? priority;
  List<Products>? grpItems;
  List<Null>? grpCategory;

  ItemGroup(
      {this.grpId,
        this.grpName,
        this.grpType,
        this.grpDesign,
        this.grpStartDate,
        this.grpEndDate,
        this.priority,
        this.grpItems,
        this.grpCategory});

  ItemGroup.fromJson(Map<String, dynamic> json) {
    grpId = json['grp_id'];
    grpName = json['grp_name'];
    grpType = json['grp_type'];
    grpDesign = json['grp_design'];
    grpStartDate = json['grp_start_date'];
    grpEndDate = json['grp_end_date'];
    priority = json['priority'];
    if (json['grp_items'] != null) {
      grpItems = <Products>[];
      json['grp_items'].forEach((v) {
        grpItems!.add(new Products.fromJson(v));
      });
    }
    // if (json['grp_category'] != null) {
    //   grpCategory = <Null>[];
    //   json['grp_category'].forEach((v) {
    //     grpCategory!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grp_id'] = this.grpId;
    data['grp_name'] = this.grpName;
    data['grp_type'] = this.grpType;
    data['grp_design'] = this.grpDesign;
    data['grp_start_date'] = this.grpStartDate;
    data['grp_end_date'] = this.grpEndDate;
    data['priority'] = this.priority;
    if (this.grpItems != null) {
      data['grp_items'] = this.grpItems!.map((v) => v.toJson()).toList();
    }
    // if (this.grpCategory != null) {
    //   data['grp_category'] = this.grpCategory!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}


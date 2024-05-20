
class CouponsResponse
{
  String? code;
  List<Coupon?>? res;

  CouponsResponse({this.code, this.res});

  CouponsResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['res'] != null) {
      res = <Coupon>[];
      json['res'].forEach((v) {
        res!.add(Coupon.fromJson(v));
      });
    }
  }
}

class Coupon {
  String? id;
  String? title;
  String? type;
  String? couponcode;
  String? startdate;
  String? enddate;
  String? minamt;
  String? maxamt;
  String? fixed;
  String? discounttype;
  String? instructions;
  String? image;

  Coupon({this.id, this.title, this.type, this.couponcode, this.startdate, this.enddate, this.minamt, this.maxamt, this.fixed, this.discounttype, this.instructions, this.image});

  Coupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    couponcode = json['couponcode'];
    startdate = json['start_date'];
    enddate = json['end_date'];
    minamt = json['min_amt'];
    maxamt = json['max_amt'];
    fixed = json['fixed'];
    discounttype = json['discount_type'];
    instructions = json['instructions'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['type'] = type;
    data['couponcode'] = couponcode;
    data['start_date'] = startdate;
    data['end_date'] = enddate;
    data['min_amt'] = minamt;
    data['max_amt'] = maxamt;
    data['fixed'] = fixed;
    data['discount_type'] = discounttype;
    data['instructions'] = instructions;
    data['image'] = image;
    return data;
  }
}



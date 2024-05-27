/*
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/

class SlotResponse {
  String? code;
  List<Res?>? res;

  SlotResponse({this.code, this.res});

  SlotResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['res'] != null) {
      res = <Res>[];
      json['res'].forEach((v) {
        if (v != null) res!.add(Res.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = code;
    data['res'] = res != null ? res!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}

class Res {
  String? storeid;
  String? storename;
  String? latitude;
  String? longitude;
  String? phone;
  String? address;
  List<Slot?>? slots;

  Res(
      {this.storeid,
      this.storename,
      this.latitude,
      this.longitude,
      this.phone,
      this.address,
      this.slots});

  Res.fromJson(Map<String, dynamic> json) {
    storeid = json['store_id'];
    storename = json['store_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    phone = json['phone'];
    address = json['address'];
    if (json['slots'] != null) {
      slots = <Slot>[];
      json['slots'].forEach((v) {
        slots!.add(Slot.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['store_id'] = storeid;
    data['store_name'] = storename;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['phone'] = phone;
    data['address'] = address;
    data['slots'] =
        slots != null ? slots!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}

class Slot {
  String? slotid;
  String? starttime;
  String? endtime;
  String? limit;

  Slot({this.slotid, this.starttime, this.endtime, this.limit});

  Slot.fromJson(Map<String, dynamic> json) {
    slotid = json['slot_id'];
    starttime = json['start_time'];
    endtime = json['end_time'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['slot_id'] = slotid;
    data['start_time'] = starttime;
    data['end_time'] = endtime;
    data['limit'] = limit;
    return data;
  }
}

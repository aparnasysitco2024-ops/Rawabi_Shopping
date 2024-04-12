class FlayerListResponse {
  String? code;
  String? message;
  List<Flayers>? res;

  FlayerListResponse({this.code, this.message, this.res});

  FlayerListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['res'] != null) {
      res = <Flayers>[];
      json['res'].forEach((v) {
        res!.add(new Flayers.fromJson(v));
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

class Flayers {
  String? title;
  String? startDate;
  String? endDate;
  String? file;

  Flayers({this.title, this.startDate, this.endDate, this.file});

  Flayers.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['file'] = this.file;
    return data;
  }
}

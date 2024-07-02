class CalculateFeeResponse {
  String? code;
  String? fee;
  String? message;

  CalculateFeeResponse({this.code, this.fee, this.message});

  CalculateFeeResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    fee = json['fee'].toString();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['fee'] = this.fee;
    data['message'] = this.message;
    return data;
  }
}

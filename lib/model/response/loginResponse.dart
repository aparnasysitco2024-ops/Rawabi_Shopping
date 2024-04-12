class LoginResponse {
  String? code;
  String? userid;
  String? phone;
  String? otp;
  String? message;

  LoginResponse({this.code, this.userid, this.phone, this.otp, this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    userid = json['userid'];
    phone = json['phone'];
    otp = json['otp'].toString();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['userid'] = userid;
    data['phone'] = phone;
    data['otp'] = otp;
    data['message'] = message;
    return data;
  }
}

class SignupResponse {
  String? code;
  String? message;
  String? otp;
  String? id;

  SignupResponse({this.code, this.message, this.otp, this.id});

  SignupResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    otp = json['otp'].toString();
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['otp'] = otp;
    data['id'] = id;
    return data;
  }
}

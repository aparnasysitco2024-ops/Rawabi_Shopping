class BaseResponse {
  String? code;
  String? message;
  String? slot;

  BaseResponse({this.code, this.message, this.slot});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    slot = json['slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['slot'] = slot;
    return data;
  }
}

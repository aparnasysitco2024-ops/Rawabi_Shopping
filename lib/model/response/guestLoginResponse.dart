class GuestLoginResponse {
  String? code;
  String? guestId;
  String? message;

  GuestLoginResponse({this.code, this.guestId, this.message});

  GuestLoginResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    guestId = json['guest_id'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['guest_id'] = guestId;
    data['message'] = message;
    return data;
  }
}

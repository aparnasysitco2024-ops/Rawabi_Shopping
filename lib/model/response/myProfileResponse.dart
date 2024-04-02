class MyProfileResponse {
  String? code;
  String? message;
  MyProfile? res;

  MyProfileResponse({this.code, this.message, this.res});

  MyProfileResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    res = json['res'] != null ? new MyProfile.fromJson(json['res']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.res != null) {
      data['res'] = this.res!.toJson();
    }
    return data;
  }
}

class MyProfile {
  String? username;
  String? email;
  String? phone;

  MyProfile({this.username, this.email, this.phone});

  MyProfile.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

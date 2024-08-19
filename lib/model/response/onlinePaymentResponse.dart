class OnlinePaymentResponse {
  String? message;
  String? code;
  String? payurl;
  String? confirmUrl;

  OnlinePaymentResponse(
      {this.message, this.code, this.payurl, this.confirmUrl});

  OnlinePaymentResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    payurl = json['payurl'];
    confirmUrl = json['confirm_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    data['payurl'] = this.payurl;
    data['confirm_url'] = this.confirmUrl;
    return data;
  }
}

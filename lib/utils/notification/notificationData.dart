class NotificationData {
  String? id;
  String? type;

  NotificationData({this.id, this.type});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    type = json['type'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['type'] = this.type.toString();
    return data;
  }
}

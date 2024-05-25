class NotificationListResponse {
  String? code;
  String? message;
  List<Notifications>? res;

  NotificationListResponse({this.code, this.message, this.res});

  NotificationListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['res'] != null) {
      res = <Notifications>[];
      json['res'].forEach((v) {
        res!.add(new Notifications.fromJson(v));
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

class Notifications {
  String? notificationId;
  String? title;
  String? message;
  String? type;
  String? usergroupId;
  String? userId;

  Notifications(
      {this.notificationId,
        this.title,
        this.message,
        this.type,
        this.usergroupId,
        this.userId});

  Notifications.fromJson(Map<String, dynamic> json) {
    notificationId = json['notification_id'];
    title = json['title'];
    message = json['message'];
    type = json['type'];
    usergroupId = json['usergroup_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_id'] = this.notificationId;
    data['title'] = this.title;
    data['message'] = this.message;
    data['type'] = this.type;
    data['usergroup_id'] = this.usergroupId;
    data['user_id'] = this.userId;
    return data;
  }
}

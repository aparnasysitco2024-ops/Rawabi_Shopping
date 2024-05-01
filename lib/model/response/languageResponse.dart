class LanguageResponse {
  String? code;
  String? message;
  List<LanguageList>? res;

  LanguageResponse({this.code, this.message, this.res});

  LanguageResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['res'] != null) {
      res = <LanguageList>[];
      json['res'].forEach((v) {
        res!.add(new LanguageList.fromJson(v));
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

class LanguageList {
  String? language;
  String? id;

  LanguageList({this.language,this.id});

  LanguageList.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    data['id'] = this.id;
    return data;
  }
}

class AutoSuggestionResponse {
  String? code;
  List<Words>? words;

  AutoSuggestionResponse({this.code, this.words});

  AutoSuggestionResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['words'] != null) {
      words = <Words>[];
      json['words'].forEach((v) {
        words!.add(new Words.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.words != null) {
      data['words'] = this.words!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Words {
  String? product;

  Words({this.product});

  Words.fromJson(Map<String, dynamic> json) {
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product;
    return data;
  }
}

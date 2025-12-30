
class Messages {
  String? tokenClass;
  String? tokenType;
  String? message;

  Messages({this.tokenClass, this.tokenType, this.message});

  Messages.fromJson(Map<String, dynamic> json) {
    tokenClass = json['token_class'];
    tokenType = json['token_type'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token_class'] = this.tokenClass;
    data['token_type'] = this.tokenType;
    data['message'] = this.message;
    return data;
  }
}
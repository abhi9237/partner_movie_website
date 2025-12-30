import '../common/messages.dart';

class TokenInvalidResponse {
  String? detail;
  String? code;
  List<Messages>? messages;

  TokenInvalidResponse({this.detail, this.code, this.messages});

  TokenInvalidResponse.fromJson(Map<String, dynamic> json) {
    detail = json['detail'];
    code = json['code'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['detail'] = this.detail;
    data['code'] = this.code;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

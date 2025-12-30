import '../common/token.dart';

class VerifyOtpResponse {
  Token? token;
  bool otpSent;
  String message;

  VerifyOtpResponse(
      {required this.token, required this.otpSent, required this.message});

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      VerifyOtpResponse(
        token: json["token"] != null ? Token.fromJson(json["token"]) : null,
        otpSent: json["otp_sent"] ?? false,
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "token": token?.toJson(),
    "otp_sent": otpSent,
    "message": message,
  };
}
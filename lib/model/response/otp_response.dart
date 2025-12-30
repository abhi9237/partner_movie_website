class OtpResponse {
  bool otpSent;
  String phoneNumber;
  String message;

  OtpResponse(
      {required this.otpSent,
        required this.phoneNumber,
        required this.message});

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      otpSent: json["otp_sent"] is bool ? json["otp_sent"] : false,
      phoneNumber: json["phone_number"] ?? "",
      message: json["message"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "otp_sent": otpSent,
    "phone_number": phoneNumber,
    "message": message,
  };
}
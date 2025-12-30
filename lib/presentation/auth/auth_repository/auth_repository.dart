import 'dart:developer';
import 'package:partner_dashboard_web_app/model/response/verify_otp_response.dart';
import '../../../model/response/otp_response.dart';
import '../../../service/api_constant/api_constant.dart';
import '../../../service/api_service/api_service.dart';

class AuthRepository {
  final ApiCall apiCall = ApiCall();

  Future<OtpResponse> sendOtp(String arg) async {
    var data = {'phone_number': arg};
    try {
      final response = await apiCall.postRequest(
        endPoint: ApiConstant.sendOtp,
        data: data,
      );

      log("Response Data: $response");
      final OtpResponse result = OtpResponse.fromJson(response.data);

      return result;
    } catch (e) {
      throw Exception("Failed to send OTP: $e");
    }
  }

  Future<VerifyOtpResponse> verifyOtp(String phone, String otp) async {
    var data = {'phone_number': phone, "otp": otp};
    try {
      final response = await apiCall.postRequest(
        endPoint: ApiConstant.verifyOtp,
        data: data,
      );

      log("Response Data: $response");
      final VerifyOtpResponse result = VerifyOtpResponse.fromJson(
        response.data,
      );

      return result;
    } catch (e) {
      throw Exception("Failed to send OTP: $e");
    }
  }
}

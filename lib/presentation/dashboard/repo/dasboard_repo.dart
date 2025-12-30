import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:partner_dashboard_web_app/model/response/partner_movie_response.dart';
import '../../../config/preference/shared_prefer.dart';
import '../../../service/api_constant/api_constant.dart';
import '../../../service/api_service/api_service.dart';

class DashboardRepository {
  final ApiCall apiCall = ApiCall();

  Future<Response> getDashBoardData({String? startDate , String? endDate}) async {
    try {
      final response = await apiCall.getRequest(
        endPoint:'${ ApiConstant.getPartnerMovies}?start_date=$startDate&end_date=$endDate',
        token: StorageService.token,
      );
      return response;
    } catch (e) {
      throw Exception("Failed to send OTP: $e");
    }
  }

  Future<Response> getProductDetail(String id,{String? startDate , String? endDate}) async {
    try {
      final response = await apiCall.getRequest(
        endPoint: '${ApiConstant.getPartnerMoviesDetail}$id/?start_date=$startDate&end_date=$endDate',
        token: StorageService.token,
      );
      return response;
    } catch (e) {
      throw Exception("Failed to send OTP: $e");
    }
  }

  Future<Response> getPartnerDetail() async {
    try {
      final response = await apiCall.getRequest(
        endPoint: ApiConstant.getUserProfile,
        token: StorageService.token,
      );
      return response;
    } catch (e) {
      throw Exception("Failed to send OTP: $e");
    }
  }

  // Future<VerifyOtpResponse> verifyOtp(String phone, String otp) async {
  //   var data = {'phone_number': phone, "otp": otp};
  //   try {
  //     final response = await apiCall.postRequest(
  //       endPoint: ApiConstant.verifyOtp,
  //       data: data,
  //     );
  //
  //     log("Response Data: $response");
  //     final VerifyOtpResponse result = VerifyOtpResponse.fromJson(
  //       response.data,
  //     );
  //
  //     return result;
  //   } catch (e) {
  //     throw Exception("Failed to send OTP: $e");
  //   }
  // }
}

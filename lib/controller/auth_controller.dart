import 'dart:async';
import 'dart:developer';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:partner_dashboard_web_app/model/response/verify_otp_response.dart';
import 'package:pinput/pinput.dart';
import '../common/common_widget/common_widget.dart';
import '../config/preference/shared_prefer.dart';
import '../config/route_constant/route_constant.dart';
import '../model/response/otp_response.dart';
import '../presentation/auth/auth_repository/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository authRepository = AuthRepository();
  final StorageService sharedPreferences = StorageService();
  final Rx<TextEditingController> mobileController =
      TextEditingController().obs;
  final Rx<TextEditingController> otpController = TextEditingController().obs;
  final RxString countryCode = '+91'.obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingOtp = false.obs;
  Timer? _timer;
  final RxInt _start = 30.obs; // The countdown duration in seconds
  final RxBool isTimerActive = false.obs;

  String get timerText =>
      'Resend OTP in ${_start.value.toString().padLeft(2, '0')}s';

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void startTimer() {
    _timer?.cancel();
    _start.value = 30;
    isTimerActive.value = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_start.value == 0) {
        isTimerActive.value = false;
        timer.cancel();
      } else {
        _start.value--;
      }
    });
    update();
  }

  void resendOtp() {
    _start.value = 30;
    startTimer();
    // For example:
    // await authRepository.sendOtp(phoneNumber.value);
  }

  void onTapSelectCountry(CountryCode code) {
    log('countryCode${code.dialCode}');
    countryCode.value = code.dialCode ?? '';
  }

  void onTapLogin(BuildContext context) async {
    if (mobileController.value.text.trim().isEmpty) {
      showToastMessage(context, 'Please enter valid mobile number');
    } else if (countryCode.isEmpty) {
      showToastMessage(context, 'Please select country');
    } else {
      isLoading.value = true;
      try {
        OtpResponse response = await authRepository.sendOtp(
          countryCode.value + mobileController.value.text,
        );
        if (response.otpSent == true) {
          if (context.mounted) {
            context.push(RouteConstant.otpVerification);
            startTimer();
          }
        } else {
          if (context.mounted) {
            showToastMessage(context, response.message);
          }
        }
      } catch (e) {
        log(e.toString());
      } finally {
        isLoading.value = false;
      }
      update();
    }
  }

  void onTapVerify(BuildContext context) async {
    if (otpController.value.length < 6) {
      showToastMessage(context, 'Please enter valid otp');
    } else {
      isLoadingOtp.value = true;
      try {
        VerifyOtpResponse response = await authRepository.verifyOtp(
          countryCode.value + mobileController.value.text,
          otpController.value.text,
        );
        if (response.otpSent == true) {
          if (context.mounted) {
            StorageService.setAuthToken(response.token?.access ?? '');
            clearController();
            context.go(RouteConstant.dashboard);
          }
        } else {
          if (context.mounted) {
            showToastMessage(context, response.message);
          }
        }
      } catch (e) {
        log(e.toString());
      } finally {
        isLoadingOtp.value = false;
      }
      update();
    }
  }

  void clearController (){
    mobileController.value.clear();
    otpController.value.clear();
  }
}

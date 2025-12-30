// import 'dart:developer';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:dio/dio.dart';
//
// class NetworkInterceptor extends Interceptor {
//
//
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
//     final connectivityResult = await Connectivity().checkConnectivity();
//
//    connectivityResult.forEach((v){
//      log('Coooo=${v.toString()}');
//
//    });
//
//     if (connectivityResult.contains(ConnectivityResult.none)) {
//       log("❌ No internet connection");
//       return handler.reject(
//         DioException(
//           requestOptions: options,
//           error: "No internet connection",
//           type: DioExceptionType.unknown,
//         ),
//       );
//     } else {
//       if (connectivityResult.contains(ConnectivityResult.wifi)) {
//         log("📶 Connected via WiFi");
//       } else if (connectivityResult.contains(ConnectivityResult.mobile)) {
//         log("📶 Connected via Mobile Data");
//       }
//       handler.next(options);
//     }
//   }
//
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     log("❌ Dio error: ${err.error}");
//     handler.next(err);
//   }
//
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     log("✅ Response received: ${response.statusCode}");
//     handler.next(response);
//   }
// }

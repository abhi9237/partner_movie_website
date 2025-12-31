import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:partner_dashboard_web_app/presentation/auth/login/login_screen.dart';
import 'package:partner_dashboard_web_app/presentation/dashboard/widget/product_detail/product_detail.dart';
import '../../presentation/auth/otp/otp_screen.dart';
import '../../presentation/dashboard/dashboard_screen.dart';
import '../preference/shared_prefer.dart';
import '../route_constant/route_constant.dart';

abstract class AppRouter {
  static GoRouter router =
  GoRouter(initialLocation: RouteConstant.login,
      redirect: (BuildContext context, GoRouterState state) async {

        final bool isLoggedIn = await StorageService.hasToken();

        final isAuthRoute = state.matchedLocation == RouteConstant.login ||
            state.matchedLocation == RouteConstant.otpVerification;

        if (!isLoggedIn && !isAuthRoute) {
          return RouteConstant.login;
        }

        if (isLoggedIn && isAuthRoute) {
          return RouteConstant.dashboard;
        }

        // 4. If none of the above conditions are met, allow navigation.
        return null;
      },


      routes: [
    GoRoute(
        path: RouteConstant.login,
        name: RouteConstant.login,
        builder: (context, state) {
          return LoginScreen();
        }),
    GoRoute(
        path: RouteConstant.otpVerification,
        name: RouteConstant.otpVerification,
        builder: (context, state) {
          return OtpScreen();
        }),
    GoRoute(
        path: RouteConstant.dashboard,
        name: RouteConstant.dashboard,
        builder: (context, state) {
          return DashBoardScreen();
        }),
  ]);
}
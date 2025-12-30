import 'package:go_router/go_router.dart';
import 'package:partner_dashboard_web_app/presentation/auth/login/login_screen.dart';
import 'package:partner_dashboard_web_app/presentation/dashboard/widget/product_detail/product_detail.dart';
import '../../presentation/auth/otp/otp_screen.dart';
import '../../presentation/dashboard/dashboard_screen.dart';
import '../route_constant/route_constant.dart';

abstract class AppRouter {
  static GoRouter router =
  GoRouter(initialLocation: RouteConstant.login, routes: [
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
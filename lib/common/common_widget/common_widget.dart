import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../config/preference/shared_prefer.dart';
import '../app_font/app_font.dart';
import '../theme/color_constant.dart';
import '../../config/route_constant/route_constant.dart';

void showLogoutPopup(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 420),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(
              colors: [
                ColorConstant.surfaceElevated.withValues(alpha: 0.96),
                ColorConstant.surfaceStrong.withValues(alpha: 0.98),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: ColorConstant.border),
            boxShadow: [
              BoxShadow(
                blurRadius: 36,
                offset: const Offset(0, 18),
                color: Colors.black.withValues(alpha: 0.35),
              ),
            ],
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.logout, color: Colors.redAccent),
              ),
              const SizedBox(height: 20),
              Text(
                'Logout',
                style: appStyle(
                  24,
                  color: ColorConstant.whiteColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Are you sure you want to log out of your partner account?',
                style: appStyle(
                  15,
                  color: ColorConstant.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => dialogContext.pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: ColorConstant.borderMuted),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: appStyle(
                          14,
                          color: ColorConstant.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () async {
                        await StorageService.clearAll();
                        if (context.mounted) {
                          context.goNamed(RouteConstant.login);
                        }
                      },
                      child: Text(
                        'Logout',
                        style: appStyle(14, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> showToastMessage({
  required String titleMessage,
  required String message,
  required BuildContext context,
  required bool isError,
}) async {
  toastification.show(
    borderSide: BorderSide(color: Colors.transparent),
    context: context,
    type: isError ? ToastificationType.error : ToastificationType.success,
    // style: ToastificationStyle.flatColored,
    autoCloseDuration: const Duration(seconds: 3),
    title: Text(
      titleMessage,
      style: TextStyle(
        fontSize: 16,
        color: ColorConstant.whiteColor,
        fontWeight: FontWeight.w700,
      ),
    ),
    description: Text(
      message,
      style: const TextStyle(
        fontSize: 14,
        color: ColorConstant.textPrimary,
        fontWeight: FontWeight.w500,
      ),
    ),
    alignment: Alignment.topCenter,
    animationDuration: const Duration(milliseconds: 300),
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(
        opacity: Tween<double>(begin: 0.3, end: 1.0).animate(animation),
        child: child,
      );
    },
    icon: isError
        ? const Icon(Icons.error_outline, color: Colors.white)
        : const Icon(Icons.check_circle_outline, color: Colors.white),
    showIcon: true,
    primaryColor:  Colors.redAccent ,
    backgroundColor:  Colors.redAccent ,
    // foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(14),
    showProgressBar: true,
    closeButton: ToastCloseButton(
      showType: CloseButtonShowType.onHover,
      buttonBuilder: (context, onClose) {
        return TextButton.icon(
          onPressed: onClose,
          icon: const Icon(Icons.close, size: 18, color: Colors.white),
          label: const Text(
            'Close',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    ),
    closeOnClick: false,
    pauseOnHover: true,
    dragToClose: true,
    onHoverMouseCursor: SystemMouseCursors.click,
    callbacks: ToastificationCallbacks(
      onTap: (toastItem) => debugPrint('Toast ${toastItem.id} tapped'),
      onCloseButtonTap: (toastItem) =>
          debugPrint('Toast ${toastItem.id} close button tapped'),
      onAutoCompleteCompleted: (toastItem) =>
          debugPrint('Toast ${toastItem.id} auto complete completed'),
      onDismissed: (toastItem) => debugPrint('Toast ${toastItem.id} dismissed'),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:legal_tech/core/widgets/global_text.dart';
import 'package:toastification/toastification.dart';

class ToastMessageHelper {
  static String? _lastMessage;
  static DateTime? _lastShowTime;

  static bool _shouldShow(String message) {
    final now = DateTime.now();
    if (_lastMessage == message &&
        _lastShowTime != null &&
        now.difference(_lastShowTime!) < const Duration(seconds: 5)) {
      return false;
    }
    _lastMessage = message;
    _lastShowTime = now;
    return true;
  }

  static ToastificationItem? showInfo({
    required String message,
    String? title,
    Duration? duration,
    AlignmentGeometry? alignment,
    bool showProgressBar = true,
    bool pauseOnHover = true,
    bool showCloseButton = true,
  }) {
    if (!_shouldShow(message)) return null;
    return toastification.show(
      type: ToastificationType.info,
      style: ToastificationStyle.fillColored,
      title: title != null
          ? GlobalText(
              text: title,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.white,
            )
          : null,
      description: GlobalText(
        text: message,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: Colors.white,
      ),
      alignment: alignment ?? Alignment.topCenter,
      autoCloseDuration: duration ?? const Duration(seconds: 4),
      closeOnClick: showCloseButton,
      pauseOnHover: pauseOnHover,
      dragToClose: true,
      applyBlurEffect: true,
    );
  }

  static ToastificationItem? showSuccess({
    required String message,
    String? title,
    Duration? duration,
    AlignmentGeometry? alignment,
    bool showProgressBar = true,
    bool pauseOnHover = true,
    bool showCloseButton = true,
  }) {
    if (!_shouldShow(message)) return null;
    return toastification.show(
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      title: title != null
          ? GlobalText(
              text: title,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.white,
            )
          : null,
      description: GlobalText(
        text: message,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: Colors.white,
      ),
      alignment: alignment ?? Alignment.topCenter,
      autoCloseDuration: duration ?? const Duration(seconds: 3),
      closeOnClick: showCloseButton,
      pauseOnHover: pauseOnHover,
      dragToClose: true,
      applyBlurEffect: true,
    );
  }

  static ToastificationItem? showError({
    required String message,
    String? title,
    Duration? duration,
    AlignmentGeometry? alignment,
    bool showProgressBar = true,
    bool pauseOnHover = true,
    bool showCloseButton = true,
  }) {
    if (!_shouldShow(message)) return null;
    return toastification.show(
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      title: title != null
          ? GlobalText(
              text: title,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.white,
            )
          : null,
      description: GlobalText(
        text: message,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: Colors.white,
      ),
      alignment: alignment ?? Alignment.topCenter,
      autoCloseDuration: duration ?? const Duration(seconds: 4),
      closeOnClick: showCloseButton,
      pauseOnHover: pauseOnHover,
      dragToClose: true,
      applyBlurEffect: true,
    );
  }

  static ToastificationItem? showWarning({
    required String message,
    String? title,
    Duration? duration,
    AlignmentGeometry? alignment,
    bool showProgressBar = true,
    bool pauseOnHover = true,
    bool showCloseButton = true,
  }) {
    if (!_shouldShow(message)) return null;
    return toastification.show(
      type: ToastificationType.warning,
      style: ToastificationStyle.fillColored,
      title: title != null
          ? GlobalText(
              text: title,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.white,
            )
          : null,
      description: GlobalText(
        text: message,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: Colors.white,
      ),
      alignment: alignment ?? Alignment.topCenter,
      autoCloseDuration: duration ?? const Duration(seconds: 4),
      closeOnClick: showCloseButton,
      pauseOnHover: pauseOnHover,
      dragToClose: true,
      applyBlurEffect: true,
    );
  }

  static ToastificationItem showCustom({
    required Widget content,
    Duration? duration,
    AlignmentGeometry? alignment,
    bool showProgressBar = true,
    bool pauseOnHover = true,
    bool showCloseButton = true,
  }) {
    return toastification.show(
      type: ToastificationType.info,
      style: ToastificationStyle.fillColored,
      description: content,
      alignment: alignment ?? Alignment.topCenter,
      autoCloseDuration: duration ?? const Duration(seconds: 4),
      showProgressBar: showProgressBar,
      closeOnClick: showCloseButton,
      pauseOnHover: pauseOnHover,
      dragToClose: true,
      applyBlurEffect: true,
    );
  }

  static void dismiss(ToastificationItem toastId) {
    toastification.dismiss(toastId);
  }

  static void dismissAll() {
    toastification.dismissAll();
  }
}

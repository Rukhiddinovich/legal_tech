import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastificationWidget {
  static ToastificationItem? _toastificationItem;

  static void showToast({
    BuildContext? context,
    required String message,
    ToastificationType? type = ToastificationType.error,
  }) {
    if (_toastificationItem != null) {
      _dismissToast(_toastificationItem!);
    }

    _toastificationItem = toastification.show(
      context: context,
      type: type,
      description: Text(
        message.tr(context: context),
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      showProgressBar: false,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 5),
      callbacks: ToastificationCallbacks(
        onTap: _dismissToast,
        onCloseButtonTap: _dismissToast,
        onAutoCompleteCompleted: _dismissToast,
        onDismissed: (toastItem) => _dismissToast,
      ),
    );
  }

  static void _dismissToast(ToastificationItem item) {
    toastification.dismiss(item);
    _toastificationItem = null;
  }
}

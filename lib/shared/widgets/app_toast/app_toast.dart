import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppToast {
  AppToast._();

  static void success(BuildContext context, String message, {String? title}) {
    _show(
      context,
      message: message,
      title: title ?? 'Sucesso',
      type: ToastificationType.success,
      icon: const Icon(Icons.check_circle, color: Colors.green),
      color: Colors.green,
    );
  }

  static void error(BuildContext context, String message, {String? title}) {
    _show(
      context,
      message: message,
      title: title ?? 'Erro',
      type: ToastificationType.error,
      icon: const Icon(Icons.error, color: Colors.red),
      color: Colors.red,
    );
  }

  static void warning(BuildContext context, String message, {String? title}) {
    _show(
      context,
      message: message,
      title: title ?? 'Atenção',
      type: ToastificationType.warning,
      icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange),
      color: Colors.orange,
    );
  }

  static void info(BuildContext context, String message, {String? title}) {
    _show(
      context,
      message: message,
      title: title ?? 'Informação',
      type: ToastificationType.info,
      icon: const Icon(Icons.info, color: Colors.blue),
      color: Colors.blue,
    );
  }

  static void _show(
    BuildContext context, {
    required String message,
    required String title,
    required ToastificationType type,
    required Icon icon,
    required Color color,
  }) {
    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.flat,
      title: Text(title),
      description: Text(message),
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 4),
      icon: icon,
      primaryColor: color,
      backgroundColor: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 16,
          offset: Offset(0, 4),
        ),
      ],
      closeButton: ToastCloseButton(showType: CloseButtonShowType.onHover),
      dragToClose: true,
      pauseOnHover: true,
    );
  }
}

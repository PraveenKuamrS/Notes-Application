import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertService {
  BuildContext? get context => null;

  void showToast({
    required String text,
    required Color color,
    IconData icon = Icons.info,
  }) {
    try {
      DelightToastBar(
          autoDismiss: true,
          position: DelightSnackbarPosition.top,
          builder: (context) {
            return ToastCard(
              color: color,
              leading: Icon(
                icon,
                size: 28,
              ),
              title: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }).show(context!);
    } catch (e) {
      print(e);
    }
  }
}

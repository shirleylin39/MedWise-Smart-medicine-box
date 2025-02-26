import 'package:flutter/material.dart';
import 'notification_style.dart';

void boxUnpairNotification(BuildContext context, VoidCallback onUnpair) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return NotificationStyle(
        title: "Warning!",
        message: "Are you sure you want to unpair current MedWise box?",
        primaryButtonText: "Unpair",
        onPrimaryPressed: () {
          Navigator.pop(context); // 先關閉彈窗
          onUnpair(); // 執行解除配對的邏輯
        },
        secondaryButtonText: "Cancel",
        onSecondaryPressed: () {
          Navigator.pop(context);
        },
      );
    },
  );
}

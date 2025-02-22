import 'package:flutter/material.dart';
import 'notification_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../connect_medwise/connect_1.dart';
import '../notification/notification.dart';


void boxPairNotification(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return NotificationStyle(
        title: "Unpaired to MedWise Box!",
        message: "Please pair your device now to continue.",
        primaryButtonText: "Pair Now",
        onPrimaryPressed: () {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: const Color(0xFFFFFFE9),
                title: const Text(
                    "Connect to MedWise",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF191717),
                      fontSize: 19,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: -0.33,
                    )
                ),
                content: Container(
              width: 300,
              height: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Push the connect button on the MedWise box to connect',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF191717),
                      fontSize: 15,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0.0, -0.1),
                    child: SvgPicture.asset(
                      'asset/icons/connect_device.svg',
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),
                  ),
                  ]


                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // 關閉配對中視窗
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        },
        secondaryButtonText: "Later",
        onSecondaryPressed: () {
          Navigator.pop(context);
        },
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'notification_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../buttons/buttons.dart';


Future<void> boxPairNotification(BuildContext context, VoidCallback onPairNow, bool isLoading, bool isPaired) {
  return showDialog(
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
                    style: TextStyle(
                      color: Color(0xFF191717),
                      fontSize: 19,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: -0.33,
                    )
                ),
                content: SizedBox(
                  width: 300,
                  height: 500,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Push the connect button on the MedWise box to connect',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF191717),
                          fontSize: 15,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    const SizedBox(
                      height: 20
                    ),
                    Align(
                      alignment: const Alignment(0.0, -0.1),
                      child: SvgPicture.asset(
                        'asset/icons/connect_device.svg',
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.4,
                      ),
                    ),
                    Align(
                      alignment: const Alignment(-0.02, -0.1),
                      child: isLoading
                          ? const SizedBox(
                        width: 69.0, // Set the desired width
                        height: 69.0, // Set the desired height
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE55733)),
                          strokeWidth: 10.0, // Adjust the stroke width as needed
                        ),
                      )
                          : isPaired
                          ? SvgPicture.asset(
                          'asset/icons/connect_check.svg')
                          : Container(),
                    ),
                  ]


                  ),
                ),
                actions: [
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MediumButton(
                      text: 'Pair Device',
                      onPressed: () {
                        onPairNow();
                      }
                    ),
                    const SizedBox(width:10),
                    MediumButton(
                      text: 'Cancel',
                      onPressed: (){
                        Navigator.pop(context);
                      }
                    ),
                  ],
                )
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
});}

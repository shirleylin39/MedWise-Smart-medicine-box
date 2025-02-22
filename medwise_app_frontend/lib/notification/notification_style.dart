import 'package:flutter/material.dart';
import '../buttons/buttons.dart';

class NotificationStyle extends StatelessWidget {
  final String title;
  final String message;
  final String primaryButtonText;
  final VoidCallback onPrimaryPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryPressed;

  const NotificationStyle({
    super.key,
    required this.title,
    required this.message,
    required this.primaryButtonText,
    required this.onPrimaryPressed,
    this.secondaryButtonText,
    this.onSecondaryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFFFFFE9),
      title: Text(
        title,
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
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xFF191717),
          fontSize: 15,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w400,
          height: 0,
        ),
      ),
      actions: [
        if (secondaryButtonText != null && onSecondaryPressed != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MediumButton(
                text: primaryButtonText,
                onPressed: onPrimaryPressed,
              ),
              const SizedBox(width:10),
              MediumButton(
                text: secondaryButtonText!,
                onPressed: onSecondaryPressed!,
              ),
            ],
          )
      else
        Center(
          child: SmallBoxButton(
            text: primaryButtonText,
            isSelected: false,
            onPressed: onPrimaryPressed,
          ),
        )
      ]
    );
  }
}

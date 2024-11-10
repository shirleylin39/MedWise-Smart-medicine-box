import 'package:flutter/material.dart';
import '../buttons/buttons.dart';

class GoBackNextButtons extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onNextPressed;

  const GoBackNextButtons({
    super.key,
    required this.onBackPressed,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0.0, 0.9),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GoBackButton(onPressed: onBackPressed),
          SizedBox(width: MediaQuery.of(context).size.width * 0.75),
          GoNextButton(onPressed: onNextPressed),
        ],
      ),
    );
  }
}
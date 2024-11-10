import 'package:flutter/material.dart';

class BoxSettingButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BoxSettingButton({
    super.key,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
            width: 32,
            height: 32,
            clipBehavior: Clip.antiAlias,
            decoration: const ShapeDecoration(
                color: Color(0xFF336BB7),
                shape: CircleBorder()
            ),
            child: const Center(
                child: Icon(
                  Icons.settings,
                  color: Color(0xFFFFFFE9),
                  size: 24,
                )
            )
        )
    );
  }
}
import 'package:flutter/material.dart';

class GoNextButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoNextButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
            width: 32,
            height: 32,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFF336BB7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Center(
                child: Icon(
                  Icons.play_arrow,
                  color: Color(0xFFFFFFE9),
                  size: 24,
                )
            )
        )
    );
  }
}
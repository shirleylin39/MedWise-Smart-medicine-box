import 'package:flutter/material.dart';

class CalendarButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CalendarButton({
    super.key,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
            width: 40,
            height: 40,
            clipBehavior: Clip.antiAlias,
            decoration: const ShapeDecoration(
                color: Color(0xFF336BB7),
                shape: CircleBorder()
            ),
            child: const Center(
                child: Icon(
                  Icons.calendar_today_outlined,
                  color: Color(0xFFFFFFE9),
                  size: 24,
                )
            )
        )
    );
  }
}
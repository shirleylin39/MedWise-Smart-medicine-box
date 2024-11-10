import 'package:flutter/material.dart';

class SmallBoxButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSelected;

  const SmallBoxButton ({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  _SmallBoxButtonState createState() => _SmallBoxButtonState();
}
class _SmallBoxButtonState extends State<SmallBoxButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: SizedBox(
        width: 103,
        height:40,
        child: Stack(
            children: [
              if (!_isPressed && !widget.isSelected)
                Stack (
                    children: [
                      Positioned(
                        left: 3,
                        top: 3,
                        child: Container(
                          width: 100,
                          height: 37,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF191717),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Color(0xFF191717)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 100,
                          height: 37,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFFFFE9),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Color(0xFF191717)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 7,
                        child: SizedBox(
                          width: 100,
                          height: 20,
                          child: Text(
                            widget.text,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF191717),
                              fontSize: 16,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.33,
                            ),
                          ),
                        ),
                      ),
                    ]
                )
              else
                Stack (
                    children: [
                      Positioned(
                        left: 3,
                        top: 3,
                        child: Container(
                          width: 100,
                          height: 37,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFCEE2FF),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Color(0xFF191717)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 3,
                        top: 10,
                        child: SizedBox(
                          width: 100,
                          height: 20,
                          child: Text(
                            widget.text,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF191717),
                              fontSize: 16,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.33,
                            ),
                          ),
                        ),
                      ),
                    ]
                )
            ]
        ),
      ),
    );
  }
}
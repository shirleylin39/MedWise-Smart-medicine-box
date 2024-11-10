import 'package:flutter/material.dart';

class BigButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const BigButton({
    super.key,
    required this.text,
    required this.onPressed
  });

  @override
  _BigButtonState createState() => _BigButtonState();
}
class _BigButtonState extends State<BigButton> {
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
          width: 200,
          height: 40,
          child: Stack(
            children: [
              if (!_isPressed)
                Stack (
                    children: [
                      Positioned(
                        left: 3,
                        top: 3,
                        child: Container(
                          width: 193.55,
                          height: 36.92,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF191717),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Color(0xFF191717)),
                              borderRadius: BorderRadius.circular(60),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 193.55,
                          height: 36.92,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFFE149),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Color(0xFF191717)),
                              borderRadius: BorderRadius.circular(60),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 23.85,
                        top: 8.53,
                        child: SizedBox(
                          width: 148.57,
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
                      left: 2.73,
                      top: 2.34,
                      child: Container(
                        width: 193.55,
                        height: 36.92,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFFE149),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Color(0xFF191717)),
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 26.58,
                      top: 10.87,
                      child: SizedBox(
                        width: 148.57,
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
                  ],
                ),
            ],
          )
      ),
    );
  }
}
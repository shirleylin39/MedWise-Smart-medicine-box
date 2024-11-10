import 'package:flutter/material.dart';

class ModeButton extends StatefulWidget {
  final String assetName;
  final String text;
  final VoidCallback onPressed;
  final bool isSelected;

  const ModeButton({
    super.key,
    required this.assetName,
    required this.text,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  _ModeButtonState createState() => _ModeButtonState();
}
class _ModeButtonState extends State<ModeButton> {
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
        width: 153,
        height:183,
        child: Stack(
            children: [
              if (!_isPressed && !widget.isSelected)
                Stack (
                    children: [
                      Positioned(
                        left: 3,
                        top: 3,
                        child: Container(
                          width: 150,
                          height: 180,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF191717),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Color(0xFF191717)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 150,
                          height: 180,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFFFFE9),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Color(0xFF191717)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 11,
                        top: 15,
                        child: SizedBox(
                          width: 130,
                          height: 130,
                          child: Image.asset(
                            widget.assetName,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 13,
                        top: 150,
                        child: SizedBox(
                          width: 130,
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
                          width: 150,
                          height: 180,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFFFFE9),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Color(0xFF191717)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 14,
                        top: 18,
                        child: SizedBox(
                          width: 130,
                          height: 130,
                          child: Image.asset(
                            widget.assetName,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 153,
                        child: SizedBox(
                          width: 130,
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
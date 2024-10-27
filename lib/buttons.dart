import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const BigButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 200,
          height: 40,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                  if (states.contains(WidgetState.pressed)) {
                    return const Color(0xFFFFE149);
                  }
                  return const Color(0xFFFFE149);
                },
              ),
              foregroundColor: WidgetStateProperty.all<Color>(const Color(0xFF191717)),
              shadowColor: WidgetStateProperty.all<Color>(const Color(0xFF191717)),
              elevation: WidgetStateProperty.resolveWith<double>(
                    (Set<WidgetState> states) {
                  if (states.contains(WidgetState.pressed)) {
                    return 0;
                  }
                  return 12;
                },
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                  side: const BorderSide(color: Color(0xFF191717)),
                ),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: -0.33,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class BigButton2 extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const BigButton2({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  _BigButton2State createState() => _BigButton2State();
}

class _BigButton2State extends State<BigButton2> {
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
      child: Stack(
        children: [
          if (!_isPressed)
            Positioned(
              left: 2.73,
              top: 2.34,
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
              top: 10.53,
              child: SizedBox(
                width: 148.57,
                height: 13.65,
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
          if (_isPressed)
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
            top: 12.87,
            child: SizedBox(
              width: 148.57,
              height: 13.65,
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
      );
    }
  }

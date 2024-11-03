import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

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

class MediumButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const MediumButton({
    super.key,
    required this.text,
    required this.onPressed
  });

  @override
  _MediumButtonState createState() => _MediumButtonState();
}
class _MediumButtonState extends State<MediumButton> {
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
          width: 130,
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
                          width: 123.55,
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
                          width: 123.55,
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
                          width: 78.57,
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
                        width: 123.55,
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
                        width: 78.57,
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

class GoBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoBackButton({
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
        decoration: ShapeDecoration(
          color: const Color(0xFF336BB7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Center(
          child: RotatedBox(
            quarterTurns: 2,
            child: Icon(
              Icons.play_arrow,
              color: Color(0xFFFFFFE9),
              size: 24,
            )
          )
        )
      )
    );
  }
}
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

class BoxInfoButton extends StatefulWidget {
  final Map<String, dynamic> device;
  final VoidCallback onPressed;
  final bool isDisabled;

  const BoxInfoButton({
    super.key,
    required this.device,
    required this.onPressed,
    this.isDisabled = false,
  });

  @override
  _BoxInfoButtonState createState() => _BoxInfoButtonState();
}
class _BoxInfoButtonState extends State<BoxInfoButton> {
  bool _isPressed = false;


  @override
  Widget build(BuildContext context) {

    DateTime? startDate;
    if (widget.device['start_date'] != null) {
      startDate = widget.device['start_date'] as DateTime;
    }

    DateTime? endDate = startDate?.add(const Duration(days: 6));
    final dateFormatter = DateFormat('dd/MM');

    final boxMode = widget.device['box_mode'];


    return GestureDetector(
      onTapDown: (_) {
        if (!widget.isDisabled){
          setState(() {
            _isPressed = true;
          });
        }
      },
      onTapUp: (_) {
        if (!widget.isDisabled) {
          setState(() {
            _isPressed = false;
          });
          widget.onPressed();
        }
      },
      onTapCancel: () {
        if (!widget.isDisabled) {
          setState(() {
            _isPressed = false;
          });
        }
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.8,
        height: 115,
        child: Stack(
          children: [
            if (!_isPressed)
            Stack (
              children: [
                Positioned(
                  left: 3,
                  top: 3,
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.79,
                    height: 112,
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
                    width: MediaQuery.of(context).size.width*0.79,
                    height: 112,
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
                  left: MediaQuery.of(context).size.width*0.05,
                  top: 10,
                  child: Row(
                    children:[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Row(
                            children:[
                              Container(
                                width: 115,
                                height: 40,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFFFE149),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Color(0xFFFFE149)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '${widget.device['taker_name']}’s Box',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFF191717),
                                      fontSize: 16,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600,
                                      height: 1.0,
                                      letterSpacing: -0.33,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 18
                              ),
                              Stack(
                                children: [
                                  if (widget.device['intake_times'] == 1)
                                   SvgPicture.asset('asset/icons/box_icon_1.svg'),
                                  if (widget.device['intake_times'] == 2)
                                  SvgPicture.asset('asset/icons/box_icon_2.svg'),
                                  if (widget.device['intake_times'] == 3)
                                      SvgPicture.asset('asset/icons/box_icon_3.svg'),
                                ],
                              )
                            ]
                          ),
                          const SizedBox(
                            height: 8
                          ),
                          Text(
                            (boxMode == 'self'
                              ? 'Self Carer\n'
                              : 'Carer: ${widget.device['carer_name']}\n') +
                            (startDate == null
                                ? 'Add a date'
                                : '${dateFormatter.format(startDate)} - ${dateFormatter.format(endDate!)}'),
                            style: const TextStyle(
                              color: Color(0xFF191717),
                              fontSize: 16,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.33,
                              height: 0
                            ),
                          ),
                        ]
                      ),
                      const SizedBox(
                        width: 50
                      ),
                      ProgressChart(progress:(widget.device['complete_percentage'] as num).toDouble(),)
                    ]
                  )
                )
              ]
            )

            else
            Stack (
              children: [
                Positioned(
                  left: 3,
                  top: 3,
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.79,
                    height: 112,
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
                    left: (MediaQuery.of(context).size.width*0.05)+3,
                    top: 13,
                    child: Row(
                        children:[
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Row(
                                    children:[
                                      Container(
                                        width: 115,
                                        height: 40,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFFFE149),
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(color: Color(0xFFFFE149)),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${widget.device['taker_name']}’s Box',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Color(0xFF191717),
                                              fontSize: 16,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600,
                                              height: 1.0,
                                              letterSpacing: -0.33,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                          width: 18
                                      ),
                                      Stack(
                                        children: [
                                          if (widget.device['intake_times'] == 1)
                                            SvgPicture.asset('asset/icons/box_icon_1.svg'),
                                          if (widget.device['intake_times'] == 2)
                                            SvgPicture.asset('asset/icons/box_icon_2.svg'),
                                          if (widget.device['intake_times'] == 3)
                                            SvgPicture.asset('asset/icons/box_icon_3.svg'),
                                        ],
                                      )
                                    ]
                                ),
                                const SizedBox(
                                    height: 8
                                ),
                                Text(
                                  (boxMode == 'self'
                                      ? 'Self Carer\n'
                                      : 'Carer: ${widget.device['carer_name']}\n') +
                                      (startDate == null
                                          ? 'Add a date'
                                          : '${dateFormatter.format(startDate)} - ${dateFormatter.format(endDate!)}'),
                                  style: const TextStyle(
                                      color: Color(0xFF191717),
                                      fontSize: 16,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.33,
                                      height: 0
                                  ),
                                ),
                              ]
                          ),
                          const SizedBox(
                              width: 50
                          ),
                          ProgressChart(progress:(widget.device['complete_percentage'] as num).toDouble(),)
                        ]
                    )
                )
              ],
            ),
          ],
        )
    )
    );
  }
}

class ProgressChart extends StatelessWidget {
  final double progress;

  const ProgressChart({super.key,
    required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(
        alignment: Alignment.center,
        children:[
          PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: progress * 100,
                  color: const Color(0xFFE55733),
                  radius: 8,
                  title: '${(progress * 100).toStringAsFixed(1)}%',
                  titleStyle: const TextStyle(
                    color: Color(0xFF191717),
                    fontSize: 16,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.33,
                    height: 0
                  ),
                ),
                PieChartSectionData(
                  value: (1 - progress) * 100,
                  color: const Color(0xFF191717),
                  radius: 8,
                  title: '',
                ),
              ],
              borderData: FlBorderData(show: false),
              centerSpaceRadius: 37,// Space in the middle
            ),
          ),
          Text(
            '${(progress * 100).toStringAsFixed(1)}%',
            style: const TextStyle(
              color: Color(0xFF191717),
              fontSize: 16,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w500,
              letterSpacing: -0.33,
            ),
          ),
        ]
      )
    );
  }
}

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
            decoration: ShapeDecoration(
              color: const Color(0xFF336BB7),
              shape: CircleBorder()
            ),
            child: const Center(
                child: RotatedBox(
                    quarterTurns: 2,
                    child: Icon(
                      Icons.settings,
                      color: Color(0xFFFFFFE9),
                      size: 24,
                    )
                )
            )
        )
    );
  }
}

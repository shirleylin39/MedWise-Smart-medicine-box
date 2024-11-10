import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../app_elements/app_elements.dart';

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
      startDate = DateTime.parse(widget.device['start_date']).toLocal();
    }

    DateTime? endDate = startDate?.add(const Duration(days: 6));
    final dateFormatter = DateFormat('MM/dd (EEE)');

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
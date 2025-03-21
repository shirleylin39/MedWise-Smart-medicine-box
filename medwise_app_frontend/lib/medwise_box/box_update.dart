import 'package:flutter/material.dart';
import '../buttons/buttons.dart';
import '../utils/api_service.dart';
import '../medwise_box/medwise_box.dart';
import '../notification/notification.dart';

class BoxUpdate extends StatefulWidget {
  final Map<String, dynamic> device;

  const BoxUpdate({
    super.key,
    required this.device});

  @override
  _BoxUpdateState createState() => _BoxUpdateState();
}
class _BoxUpdateState extends State<BoxUpdate> {
  late final String deviceID;
  late TextEditingController _yourName;
  late TextEditingController _otherName;
  late String boxMode;
  late int intakeTimes;
  late String reminderSetting;
  late String ledColor;
  late bool isPaired;
  late String? serialNumber;
  late DateTime? startDate;

  @override
  void initState() {
    super.initState();
    deviceID = widget.device['_id'];
    _yourName = TextEditingController(
      text: widget.device['box_mode'] == 'self'
          ? widget.device['taker_name']
          : widget.device['carer_name'],
    );
    _yourName.addListener(() {
      setState(() {});
    });

    _otherName= TextEditingController(
        text: widget.device['box_mode'] == 'others'
            ? widget.device['taker_name']
            : null
    );
    _otherName.addListener(() {
      setState(() {});
    });

    boxMode = widget.device['box_mode'];
    intakeTimes = widget.device['intake_times'];
    reminderSetting = widget.device['reminder_setting'];
    ledColor = widget.device['led_color'];
    isPaired = widget.device['is_paired'];
    serialNumber = widget.device['serial_number'];
    startDate = widget.device['start_date'] != null
        ? DateTime.parse(widget.device['start_date'])
        : null;
  }

  @override
  void dispose() {
    _yourName.dispose();
    _otherName.dispose();
    super.dispose();
  }

  Map<String, dynamic> updatedData() {
    return {
      'taker_name': boxMode == 'self'
          ? _yourName.text
          : _otherName.text,
      'carer_name': boxMode == 'others'
          ? _yourName.text
          : null,
      'box_mode': boxMode,
      'intake_times': intakeTimes,
      'reminder_setting': reminderSetting,
      'led_color': ledColor,
      'is_paired': isPaired,
      'serial_number': serialNumber,
      'start_date': startDate,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFE9),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFE9),
          ),
          child: Stack(
              children:[
                Align(
                    alignment: const Alignment(-0.4, -0.74),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width*0.7,
                        height: MediaQuery.of(context).size.height*0.2,
                        child: const Text(
                            'MedWise Box Setting',
                            style: TextStyle(
                              color: Color(0xFF191717),
                              fontSize: 19,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                              height: 0,
                              letterSpacing: -0.33,
                            )
                        )
                    )
                ),
                Align(
                    alignment: const Alignment(0.0, 0.2),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width*0.8,
                        height: MediaQuery.of(context).size.height*0.7,
                        child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children:[
                              const Text(
                                'Your Name\n',
                                style: TextStyle(
                                  color: Color(0xFF191717),
                                  fontSize: 16,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                  height: 0.7,
                                ),
                              ),
                              Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.82,
                                      height: 45,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFFFFFE9),
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(width: 2, color: Color(0xFF191717)),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 10,
                                      top: 10,
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.6,
                                        height: 26,
                                        child: TextField(
                                          controller: _yourName,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Enter your name',
                                            hintStyle: TextStyle(
                                              color: const Color(0xFF191717).withOpacity(0.5),
                                              fontSize: 16,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          style: const TextStyle(
                                            color: Color(0xFF191717),
                                            fontSize: 16,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]
                              ),
                              const SizedBox(
                                  height: 20
                              ),
                              const Text(
                                'Mode\n',
                                style: TextStyle(
                                  color: Color(0xFF191717),
                                  fontSize: 16,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                  height: 0.7,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SmallModeButton(
                                    text: 'Self Carer',
                                    isSelected: boxMode == "self",
                                    onPressed:(){
                                      setState((){
                                        boxMode = "self";
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                      width: 23
                                  ),
                                  SmallModeButton(
                                      text: 'Carer for others',
                                      isSelected: boxMode == "others",
                                      onPressed:(){
                                        setState((){
                                          boxMode = "others";
                                        });
                                      }
                                  ),
                                ],
                              ),

                              if (boxMode == "others") ...[
                                const SizedBox(
                                    height: 20
                                ),
                                const Text(
                                  'Name of the person\n',
                                  style: TextStyle(
                                    color: Color(0xFF191717),
                                    fontSize: 16,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600,
                                    height: 0.7,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.82,
                                  height: MediaQuery.of(context).size.width * 0.12,
                                  child: Stack(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.82,
                                          height: 45,
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFFFFFFE9),
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(width: 2, color: Color(0xFF191717)),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 10,
                                          top: 10,
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            height: 26,
                                            child: TextField(
                                              controller: _otherName,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Enter the medicine intaker's name",
                                                hintStyle: TextStyle(
                                                  color: const Color(0xFF191717).withOpacity(0.5),
                                                  fontSize: 16,
                                                  fontFamily: 'Urbanist',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              style: const TextStyle(
                                                color: Color(0xFF191717),
                                                fontSize: 16,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                  ),
                                )
                              ],
                              const SizedBox(
                                  height: 20
                              ),
                              const Text(
                                'Layers\n',
                                style: TextStyle(
                                  color: Color(0xFF191717),
                                  fontSize: 16,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                  height: 0.7,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SmallBoxButton(
                                    text: '1',
                                    isSelected: intakeTimes == 1,
                                    onPressed:(){
                                      setState((){
                                        intakeTimes = 1;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  SmallBoxButton(
                                      text: '2',
                                      isSelected: intakeTimes == 2,
                                      onPressed:(){
                                        setState((){
                                          intakeTimes = 2;
                                        });
                                      }
                                  ),
                                  const SizedBox(width: 10),
                                  SmallBoxButton(
                                      text: '3',
                                      isSelected: intakeTimes == 3,
                                      onPressed:(){
                                        setState((){
                                          intakeTimes = 3;
                                        });
                                      }
                                  ),
                                ],
                              ),
                              const SizedBox(
                                  height: 20
                              ),
                              const Text(
                                'Reminder\n',
                                style: TextStyle(
                                  color: Color(0xFF191717),
                                  fontSize: 16,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                  height: 0.7,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SmallBoxButton(
                                    text: 'Only App',
                                    isSelected: reminderSetting == 'only app',
                                    onPressed:(){
                                      setState((){
                                        reminderSetting = 'only app';
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  SmallBoxButton(
                                      text: 'Only Box',
                                      isSelected: reminderSetting == 'only box',
                                      onPressed:(){
                                        setState((){
                                          reminderSetting = 'only box';
                                        });
                                      }
                                  ),
                                  const SizedBox(width: 10),
                                  SmallBoxButton(
                                      text: 'Both',
                                      isSelected: reminderSetting == 'both',
                                      onPressed:(){
                                        setState((){
                                          reminderSetting = 'both';
                                        });
                                      }
                                  ),
                                ],
                              ),
                              const SizedBox(
                                  height: 20
                              ),
                              const Text(
                                'LED Light\n',
                                style: TextStyle(
                                  color: Color(0xFF191717),
                                  fontSize: 16,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                  height: 0.7,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SmallBoxButton(
                                    text: 'Red',
                                    isSelected: ledColor == 'red',
                                    onPressed:(){
                                      setState((){
                                        ledColor = 'red';
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  SmallBoxButton(
                                      text: 'White',
                                      isSelected: ledColor == 'white',
                                      onPressed:(){
                                        setState((){
                                          ledColor = 'white';
                                        });
                                      }
                                  ),
                                  const SizedBox(width: 10),
                                  SmallBoxButton(
                                      text: 'Off',
                                      isSelected: ledColor == 'off',
                                      onPressed:(){
                                        setState((){
                                          ledColor = 'off';
                                        });
                                      }
                                  ),
                                ],
                              ),
                              const SizedBox(
                                  height: 30
                              ),
                              Center(
                                child:
                                  SmallModeButton(
                                    text: 'Unpair Medwise Box',
                                    isSelected: false,
                                    onPressed:() {
                                      boxUnpairNotification(context, () async {
                                        setState(() {
                                          isPaired = false;
                                          serialNumber = null;
                                          startDate = null;
                                        });
                                        await updateDevice(
                                            context, deviceID, updatedData());
                                        Map<String,
                                            dynamic> updatedDevice = await fetchDeviceById(
                                            deviceID, widget.device);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (
                                              context) => const BoxMain()),
                                        );
                                      },
                                      );
                                    }
                                  ),
                                )
                            ],
                        ),
                    ),
                ),
                Align(
                  alignment: const Alignment(0.0, 0.8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                      children: [
                      MediumButton(
                        text: 'Save',
                        onPressed: () async {
                        await updateDevice(context, deviceID, updatedData());
                        Map<String, dynamic> updatedDevice = await fetchDeviceById(deviceID, widget.device);
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BoxDetails(device: updatedDevice)),
                          );
                        },
                      ),
                      const SizedBox(width: 20),
                      MediumButton(
                          text: 'Cancel',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BoxDetails(device: widget.device)),
                            );
                          }
                      ),
                    ],
                  ),
                ),
              ]
          ),
        )
    );
  }
}
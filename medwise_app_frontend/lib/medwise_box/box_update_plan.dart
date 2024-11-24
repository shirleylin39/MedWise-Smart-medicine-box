import 'package:flutter/material.dart';
import '../buttons/buttons.dart';
import '../utils/api_service.dart';
import '../app_elements/app_elements.dart';
import '../medwise_box/medwise_box.dart';

class BoxUpdatePlan extends StatefulWidget {
  final Map<String, dynamic> device;

  const BoxUpdatePlan({
    super.key,
    required this.device});

  @override
  _BoxUpdatePlanState createState() => _BoxUpdatePlanState();
}
class _BoxUpdatePlanState extends State<BoxUpdatePlan> {
  late final String deviceID;
  late final int intakeTimes;
  late DateTime? startDate;
  late TextEditingController _layer1Name;
  late TimeOfDay? layer1Time;
  late TextEditingController _layer2Name;
  late TimeOfDay? layer2Time;
  late TextEditingController _layer3Name;
  late TimeOfDay? layer3Time;
  late String? reminderSound;
  late TextEditingController _reminderNote;

  String timeOfDayToString(TimeOfDay time) {
    return time.format(context);
  }

  TimeOfDay? stringToTimeOfDay(String? timeString) {
    if (timeString == null || !timeString.contains(':')) {
      return null;
    }

    try {
      RegExp regExp = RegExp(r'(\d+):(\d+)\s?(AM|PM)', caseSensitive: false);
      Match? match = regExp.firstMatch(timeString);

      if (match != null) {
        int hour = int.parse(match.group(1)!);
        int minute = int.parse(match.group(2)!);
        String period = match.group(3)!.toUpperCase();

        if (period == 'PM' && hour != 12) {
          hour += 12;
        } else if (period == 'AM' && hour == 12) {
          hour = 0;
        }

        return TimeOfDay(hour: hour, minute: minute);
      } else {
        return null;
      }
    } catch (e) {
      logger.e('Error parsing timeString: $e');
      return null; // Return null if parsing fails
    }
  }


  final List<String> reminderSoundList = [
    'beep',
    'soft music',
    'chime',
    'bell',
    'alert',
    'melody',
    'harp',
    'whistle'
  ];

  @override
  void initState() {
    super.initState();
    deviceID = widget.device['_id'];
    intakeTimes = widget.device['intake_times'];
    startDate = widget.device['start_date'] != null
        ? DateTime.parse(widget.device['start_date'])
        : null;
    _layer1Name = TextEditingController(
        text: widget.device['layer1_name']
    );
    layer1Time = stringToTimeOfDay(widget.device['layer1_time']);
    _layer2Name = TextEditingController(
        text: widget.device['layer2_name']
    );
    layer2Time = stringToTimeOfDay(widget.device['layer2_time']);
    _layer3Name = TextEditingController(
        text: widget.device['layer3_name']
    );
    layer3Time = stringToTimeOfDay(widget.device['layer3_time']);
    reminderSound = widget.device['reminder_sound'];
    _reminderNote = TextEditingController(
        text: widget.device['reminder_note']
    );
  }

  Map<String, dynamic> updatedPlan() {
    return {
      'start_date': startDate?.toIso8601String(),
      'layer1_name': _layer1Name.text,
      'layer1_time': timeOfDayToString(layer1Time!),
      'layer2_name': intakeTimes != 1
          ? _layer2Name.text
          : null,
      'layer2_time': intakeTimes != 1
          ? timeOfDayToString(layer2Time!)
          : null,
      'layer3_name': intakeTimes == 3
          ? _layer3Name.text
          : null,
      'layer3_time': intakeTimes == 3
          ? timeOfDayToString(layer3Time!)
          : null,
      'reminder_sound': reminderSound,
      'reminder_note': _reminderNote.text
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
              children: [
                Align(
                    alignment: const Alignment(-0.4, -0.74),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width*0.7,
                        height: MediaQuery.of(context).size.height*0.2,
                        child: const Text(
                            'Update Medicine Intake Plan',
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
                                'Duration\n',
                                style: TextStyle(
                                  color: Color(0xFF191717),
                                  fontSize: 16,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                  height: 0.7,
                                ),
                              ),
                              DateSelector(
                                  startDate: startDate,
                                  newStartDate: (selectedStartDate) {
                                    setState(() {
                                      startDate = selectedStartDate;
                                    });
                                  }
                              ),
                              const SizedBox(
                                  height: 20
                              ),
                              const Text(
                                'Layer 1\n',
                                style: TextStyle(
                                  color: Color(0xFF191717),
                                  fontSize: 16,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                  height: 0.7,
                                ),
                              ),
                              Row (
                                  children: [
                                    Stack(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.53,
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
                                            left: 12,
                                            top: 12,
                                            child: SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              height: 26,
                                              child: TextField(
                                                controller: _layer1Name,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Enter medicine name',
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
                                        width: 8
                                    ),
                                    TimeSelector(
                                        layerTime: layer1Time,
                                        newLayerTime: (selectedTime) {
                                          setState(() {
                                            layer1Time = selectedTime;
                                          });
                                        }
                                    )
                                  ]
                              ),
                              if (intakeTimes != 1) ...[
                                const SizedBox(
                                    height: 20
                                ),
                                const Text(
                                  'Layer 2\n',
                                  style: TextStyle(
                                    color: Color(0xFF191717),
                                    fontSize: 16,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600,
                                    height: 0.7,
                                  ),
                                ),
                                Row (
                                    children: [
                                      Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.53,
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
                                              left: 12,
                                              top: 12,
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.5,
                                                height: 26,
                                                child: TextField(
                                                  controller: _layer2Name,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Enter medicine name',
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
                                          width: 8
                                      ),
                                      TimeSelector(
                                          layerTime: layer2Time,
                                          newLayerTime: (selectedTime) {
                                            setState(() {
                                              layer2Time = selectedTime;
                                            });
                                          }
                                      )
                                    ]
                                )
                              ],
                              if (intakeTimes == 3) ...[
                                const SizedBox(
                                    height: 20
                                ),
                                const Text(
                                  'Layer 3\n',
                                  style: TextStyle(
                                    color: Color(0xFF191717),
                                    fontSize: 16,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600,
                                    height: 0.7,
                                  ),
                                ),
                                Row (
                                    children: [
                                      Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.53,
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
                                              left: 12,
                                              top: 12,
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.5,
                                                height: 26,
                                                child: TextField(
                                                  controller: _layer3Name,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Enter medicine name',
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
                                          width: 8
                                      ),
                                      TimeSelector(
                                          layerTime: layer3Time,
                                          newLayerTime: (selectedTime) {
                                            setState(() {
                                              layer3Time = selectedTime;
                                            });
                                          }
                                      )
                                    ]
                                )
                              ],
                              const SizedBox(
                                  height: 25
                              ),
                              const Text(
                                'Notification Sound',
                                style: TextStyle(
                                  color: Color(0xFF191717),
                                  fontSize: 16,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                  height: 0.7,
                                ),
                              ),
                              const SizedBox(
                                  height: 10
                              ),
                              Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.8,
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
                                      left: 12,
                                      top: 0,
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.75,
                                        height: 26,
                                        child: DropdownButtonFormField<String>(
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                          value: reminderSound,
                                          hint: Text(
                                            'Choose a sound',
                                            style: TextStyle(
                                              color: const Color(0xFF191717).withOpacity(0.5),
                                              fontSize: 16,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          dropdownColor: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          elevation: 0,
                                          iconEnabledColor: const Color(0xFF191717),
                                          items: reminderSoundList.map((String sound) {
                                            return DropdownMenuItem<String>(
                                              value: sound,
                                              child: Text(
                                                sound,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Urbanist',
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              reminderSound = newValue;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ]
                              ),

                              const SizedBox(
                                  height: 20
                              ),
                              Column(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Note',
                                      style: TextStyle(
                                        color: Color(0xFF191717),
                                        fontSize: 16,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w600,
                                        height: 0.7,
                                      ),
                                    ),
                                    const SizedBox(
                                        height: 10
                                    ),
                                    Stack(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.8,
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
                                            left: 12,
                                            top: 12,
                                            child: SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              height: 26,
                                              child: TextField(
                                                controller: _reminderNote,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Enter Note',
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
                                  ]
                              )
                            ]
                        )
                    )
                ),
                Align(
                  alignment: const Alignment(0.0, 0.8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MediumButton(
                        text: 'Save',
                        onPressed: ()  async {
                          await updateDevice(context, deviceID, updatedPlan());
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
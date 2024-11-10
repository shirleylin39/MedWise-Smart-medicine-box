import 'package:flutter/material.dart';
import 'buttons.dart';
import 'welcome_page.dart';
import 'api_service.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'app_elements.dart';


class BoxMain extends StatefulWidget {
  const BoxMain({super.key});

  @override
  _BoxMainState createState() => _BoxMainState();
}
class _BoxMainState extends State<BoxMain> {
  List<dynamic> devices = [];

  @override
  void initState() {
    super.initState();
    getDevices();
  }

  Future<void> getDevices() async {
    // Use the service to fetch devices
    List<dynamic> currentDevices = await fetchDevices();
    setState(() {
      devices = currentDevices;
      devices.sort((a, b) => b['updatedAt'].compareTo(a['updatedAt']));
    });
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
              alignment: const Alignment(0.0, -0.75),
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.7,
                height: MediaQuery.of(context).size.height*0.2,
                child: const Text(
                  'Current MedWise Boxes',
                  style: TextStyle(
                    color: Color(0xFF191717),
                    fontSize: 25,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w700,
                    height: 0,
                    letterSpacing: -0.33,
                  )
                )
              )
            ),
            Align(
              alignment: const Alignment(0.0, 0.1),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width * 0.85,
                child: ListView.builder(
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    final device = devices[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BoxInfoButton(
                        device: device,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) => BoxDetails(device: device),
                            ),
                          );
                        }
                      ),
                    );
                  },
                ),
              )
            ),
            Align(
                alignment: const Alignment(-0.9, 0.9),
                child:GoBackButton(
                    onPressed: (){
                      Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context) => const Welcome(),
                      ),
                      );
                    }
                )
            )
          ]
        )
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: const Color(0xFFFFFFE9),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}

class BoxDetails extends StatelessWidget {
  final Map<String, dynamic> device;

  const BoxDetails({
    super.key,
    required this.device,
  });

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
              alignment: const Alignment(0.0, -0.8),
              child: BoxInfoButton(
                device: device,
                onPressed:(){},
                isDisabled: true,
              ),
            ),
          BoxCalendar(
            deviceID: device['_id'],
            onDaySelected: (selectedDay) {
              print('Selected Day: $selectedDay');
              print('Device ID: ${device['_id']}');
            },
          ),
            Align(
              alignment: const Alignment(0.75, -0.6),
              child:BoxSettingButton(
                onPressed: (){
                  Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) => BoxUpdate(device: device),
                    ),
                  );
                }
              )
            ),
            Align(
              alignment: const Alignment(0.75, 0.2),
              child:BoxSettingButton(
                onPressed: (){
                  Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) => BoxUpdatePlan(device: device),
                    ),
                  );
                }
              )
            ),
            Align(
              alignment: const Alignment(-0.9, 0.9),
              child:GoBackButton(
                onPressed: (){
                  Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) => const BoxMain(),
                    ),
                  );
                }
              )
            )
          ]
        )
      )
    );
  }
}

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
      'led_color': ledColor
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


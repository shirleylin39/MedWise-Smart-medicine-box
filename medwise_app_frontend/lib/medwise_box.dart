import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';
import 'buttons.dart';
import 'welcome_page.dart';
import 'providers.dart';
import 'api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BoxMain extends StatefulWidget {
  const BoxMain({super.key});

  @override
  _BoxMainState createState() => _BoxMainState();
}
class _BoxMainState extends State<BoxMain> {
  List<dynamic> devices = [];
  final deviceService = DeviceService();// To store the fetched device data

  @override
  void initState() {
    super.initState();
    getDevices(); // Fetch data when the widget is first loaded
  }

  Future<void> getDevices() async {
    // Use the service to fetch devices
    List<dynamic> currentDevices = await deviceService.fetchDevices();
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


class BoxDetails extends StatefulWidget {
  final Map<String, dynamic> device;

  const BoxDetails({
    super.key,
    required this.device,
  });

  @override
  _BoxDetailsState createState() => _BoxDetailsState();
}

class _BoxDetailsState extends State<BoxDetails> {
  late Map<String, dynamic> updatedDevice;
  final deviceService = DeviceService();

  @override
  void initState() {
    super.initState();
    updatedDevice = widget.device;
    fetchUpdatedDevice();
  }

  Future<void> fetchUpdatedDevice() async {
    try {
      // Pass the device ID from the widget to fetchDeviceById
      final fetchedDevice = await deviceService.fetchDeviceById(widget.device['_id']);
      if (fetchedDevice != null) {
        setState(() {
          updatedDevice = fetchedDevice;
        });
      }
    } catch (e) {
      print('Error fetching updated device: $e');
    }
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
              alignment: const Alignment(0.0, -0.8),
              child: BoxInfoButton(
                device: widget.device,
                onPressed:(){},
                isDisabled: true,
              ),
            ),
            Align(
              alignment: const Alignment(-0.5, -0.4),
              child:BoxSettingButton(
                onPressed: (){
                  Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) => BoxUpdate(device: widget.device),
                    ),
                  );
                }
              )
            ),
            Align(
              alignment: const Alignment(-0.5, 0.2),
              child:BoxSettingButton(
                onPressed: (){
                  Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) => const BoxMain(),
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
  String? deviceID;
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
                        height: 0,
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
                        height: 0,
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
                          height: 0,
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
                        height: 0,
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
                        height: 0,
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
                        height: 0,
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
              alignment: const Alignment(0.0, 0.85),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MediumButton(
                    text: 'Save',
                    onPressed: ()  async {
                      final deviceService = DeviceService();
                      await deviceService.updateDevice(context, deviceID, updatedData());
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BoxDetails(device: widget.device)),
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


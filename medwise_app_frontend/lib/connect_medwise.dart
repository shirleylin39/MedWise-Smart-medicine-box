import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'buttons.dart';
import 'welcome_page.dart';
import 'providers.dart';
import 'medwise_box.dart';
import 'api_service.dart';

class Connect1 extends StatefulWidget {
  const Connect1({super.key});

  @override
  _Connect1State createState() => _Connect1State();
}
class _Connect1State extends State<Connect1> {
  bool _isPaired = false;
  bool _isLoading = false;

  Future<void> simulateBluetoothPairing() async {
    setState(() {
      _isLoading = true;
    });

    if (!mounted) return;


    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isPaired = true;
      _isLoading = false;
    });

    String randomSerialNumber = String.fromCharCodes(
      List.generate(8, (index) => Random().nextInt(26) + 65)
    );

    Provider.of<ConnectProvider>(context, listen: false).setPaired(true);
    Provider.of<ConnectProvider>(context, listen: false).setSerialNumber(randomSerialNumber);
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
              alignment: const Alignment(-0.4, -0.7),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.width * 0.2,
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    final items = [
                      {'instruction': 'Push the connect button on the MedWise box to connect'},
                    ];

                    final item = items[index];

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, right: 15.0),
                          child: Text(
                            '${index + 1}.',
                            style: const TextStyle(
                              color: Color(0xFF191717),
                              fontSize: 19,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: '${item['instruction']} ',
                              style: const TextStyle(
                                color: Color(0xFF191717),
                                fontSize: 19,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ]
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.0, -0.1),
              child: SvgPicture.asset(
                'asset/icons/connect_device.svg',
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.4,
              ),
            ),
            Align(
              alignment: const Alignment(0.0, 0.5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MediumButton(
                    text: 'Pair Now',
                    onPressed: () async {
                      await simulateBluetoothPairing();
                    },
                  ),
                  const SizedBox(width: 20),
                  MediumButton(
                    text: 'Pair Later',
                    onPressed: () {
                      Provider.of<ConnectProvider>(context, listen: false).setPaired(false);
                      Provider.of<ConnectProvider>(context, listen: false).setSerialNumber(null);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Connect2()),
                      );
                    }
                  ),
                ],
              ),
            ),
            Align(
              alignment: const Alignment(-0.02, -0.1),
              child: _isLoading
                ? const SizedBox(
                width: 69.0, // Set the desired width
                height: 69.0, // Set the desired height
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE55733)),
                  strokeWidth: 10.0, // Adjust the stroke width as needed
                ),
              )
                : _isPaired
                  ? SvgPicture.asset(
                  'asset/icons/connect_check.svg')
                  : Container(),
            ),
            Align(
              alignment: const Alignment(-0.9, 0.9),
              child: GoBackButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Welcome()),
                  );
                },
              ),
            ),
            Align(
              alignment: const Alignment(0.9, 0.9),
              child: _isPaired
                ? GoNextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Connect2()),
                    );
                  },
                )
                : Container()
            ),
          ]
        )
      ),
    );
  }
}

class Connect2 extends StatefulWidget {
  const Connect2({super.key});

  @override
  _Connect2State createState() => _Connect2State();
}
class _Connect2State extends State<Connect2> {
  String boxMode = "";
  final TextEditingController _yourName = TextEditingController();
  final TextEditingController _otherName = TextEditingController();

  @override
  void initState() {
    super.initState();
    _yourName.addListener(() {
      setState(() {});
    });
    _otherName.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _yourName.dispose();
    _otherName.dispose();
    super.dispose();
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
              alignment: const Alignment(-0.4, -0.7),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.width * 0.2,
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    final items = [
                      {'instruction': 'Set up your MedWise'},
                    ];

                    final item = items[index];

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, right: 15.0),
                          child: Text(
                            '${index + 2}.',
                            style: const TextStyle(
                              color: Color(0xFF191717),
                              fontSize: 19,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: '${item['instruction']} ',
                              style: const TextStyle(
                                color: Color(0xFF191717),
                                fontSize: 19,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ]
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.0, 0.2),
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.8,
                height: MediaQuery.of(context).size.height*0.6,
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
                    ),
                    const SizedBox(
                      height: 20
                    ),
                    const Text(
                      'Select Mode\n',
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
                        ModeButton(
                          assetName: 'asset/icons/connect_selfmode.png',
                          text: 'Self Carer',
                          isSelected: boxMode == "self",
                          onPressed: () {
                            setState(() {
                              boxMode = "self";
                            });
                          },
                        ),
                        const SizedBox(width: 10),

                        ModeButton(
                          assetName: 'asset/icons/connect_othermode.png',
                          text: 'Carer for others',
                          isSelected: boxMode == "others",
                          onPressed: () {
                            setState(() {
                              boxMode = "others";
                            });
                          }
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20
                    ),
                    if (boxMode == "others") ...[
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
                    ]
                  ]
                )
              )
            ),
            Align(
              alignment: const Alignment(-0.9, 0.9),
              child: GoBackButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Connect1()),
                  );
                },
              ),
            ),
            Align(
              alignment: const Alignment(0.9, 0.9),
              child: (boxMode == "self" && _yourName.text.isNotEmpty) || (boxMode == "others" && _otherName.text.isNotEmpty && _yourName.text.isNotEmpty)
                ? GoNextButton(
                  onPressed: () {
                    final provider = Provider.of<ConnectProvider>(context, listen: false);

                    if (boxMode == "self") {
                      provider.setTakerName(_yourName.text);
                      provider.setBoxMode("self");
                    } else if (boxMode == "others") {
                      provider.setTakerName(_otherName.text);
                      provider.setCarerName(_yourName.text);
                      provider.setBoxMode("others");
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Connect3()),
                      );
                    },
                  )
                : Container()
            )
          ]
        )
      ),
    );
  }
}

class Connect3 extends StatefulWidget {
  const Connect3({super.key});

  @override
  _Connect3State createState() => _Connect3State();
}
class _Connect3State extends State<Connect3> {
  int currentNumber = 1;

  void _increment() {
    if (currentNumber < 3) {
      setState(() {
        currentNumber++;
      });
    }
  }

  void _decrement() {
    if (currentNumber > 1) {
      setState(() {
        currentNumber--;
      });
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
          children: [
            Align(
              alignment: const Alignment(-0.4, -0.7),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.width * 0.2,
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    final items = [
                      {'instruction': 'How many MedWise layers do you want to use?'},
                    ];

                    final item = items[index];

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, right: 15.0),
                          child: Text(
                            '${index + 3}.',
                            style: const TextStyle(
                              color: Color(0xFF191717),
                              fontSize: 19,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: '${item['instruction']} ',
                              style: const TextStyle(
                                color: Color(0xFF191717),
                                fontSize: 19,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ]
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.26
                  ),
                  Container(
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF191717), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, color: Color(0xFF191717),size: 20),
                          onPressed: _decrement,
                        ),
                        SizedBox(
                          width: 20,
                          child: Text(
                            '$currentNumber',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                              height: 0,
                              color: Color(0xFF191717),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: Color(0xFF191717),size: 20),
                          onPressed: _increment,
                        ),
                      ]
                    )
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: MediaQuery.of(context).size.height*0.45,
                    child: Stack(
                      children: [
                        Positioned(
                          left: MediaQuery.of(context).size.width*0.19,
                          top: MediaQuery.of(context).size.height*0.25,
                          child: SvgPicture.asset(
                            'asset/icons/medwise_box.svg',
                            width: MediaQuery.of(context).size.width*0.4,
                            height:MediaQuery.of(context).size.height*0.15,
                          )
                        ),
                        if (currentNumber >= 2)
                          Positioned(
                            left: MediaQuery.of(context).size.width * 0.19,
                            top: MediaQuery.of(context).size.height * 0.19,
                            child: SvgPicture.asset(
                              'asset/icons/medwise_box.svg',
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.15,
                            ),
                          ),
                        if (currentNumber == 3)
                        Positioned(
                          left: MediaQuery.of(context).size.width * 0.19,
                          top: MediaQuery.of(context).size.height * 0.13,
                          child: SvgPicture.asset(
                            'asset/icons/medwise_box.svg',
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.15,
                          ),
                        )
                      ]
                    )
                  ),
                  Text(
                    'Taking medicine $currentNumber times/ day',
                    style: const TextStyle(
                      color: Color(0xFF191717),
                      fontSize: 16,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                    )
                  )
                ]
              )
            ),
            GoBackNextButtons(
              onBackPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const Connect2()),
                );
              },
              onNextPressed: () async {
                final deviceService = DeviceService();
                Provider.of<ConnectProvider>(context, listen: false)
                    .setIntakeTimes(currentNumber);
                final newDevice = Provider.of<ConnectProvider>(context, listen: false).getDeviceInfo();
                await deviceService.submitDevice(context, newDevice);
                Provider.of<ConnectProvider>(context, listen: false).reset();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const Connect4()),
                );
              }
            ),
          ]
        )
      ),
    );
  }
}

class Connect4 extends StatelessWidget {
  const Connect4({super.key});

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
              alignment: const Alignment(-0.4, -0.6),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.2,
                child: const Text(
                  'Setting complete!\nYour new MedWise box is added to the box list.',
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
              alignment: const Alignment(0.0, -0.3),
              child: SvgPicture.asset(
                'asset/icons/pills.svg',
                width: MediaQuery.of(context).size.width * 0.19,
                height: MediaQuery.of(context).size.height * 0.18,
              ),
            ),
            Align(
              alignment: const Alignment(0.0, 0.14),
              child: SvgPicture.asset(
                'asset/icons/medwise_box.svg',
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.172,
              ),
            ),
            Align(
              alignment: const Alignment(0.0, 0.48),
              child: BigButton(
                text: 'Check my box list!',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BoxMain()),
                  );
                }
              ),
            ),
          ]
        ),
      ),
    );
  }
}




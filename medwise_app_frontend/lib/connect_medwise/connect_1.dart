import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../buttons/buttons.dart';
import '../welcome_page.dart';
import '../utils/providers.dart';
import '../connect_medwise/connect_medwise.dart';

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

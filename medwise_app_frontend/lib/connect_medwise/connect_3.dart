import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../buttons/buttons.dart';
import '../utils/providers.dart';
import '../utils/api_service.dart';
import '../connect_medwise/connect_medwise.dart';

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
                      Provider.of<ConnectProvider>(context, listen: false)
                          .setIntakeTimes(currentNumber);
                      final newDevice = Provider.of<ConnectProvider>(context, listen: false).getDeviceInfo();
                      await submitDevice(context, newDevice);
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
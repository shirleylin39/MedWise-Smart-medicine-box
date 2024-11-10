import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../buttons/buttons.dart';
import '../welcome_page.dart';
import '../about_medwise/about_medwise.dart';

class About1 extends StatelessWidget {
  const About1({super.key});

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
                        width: MediaQuery.of(context).size.width*0.7,
                        height: MediaQuery.of(context).size.height*0.2,
                        child: const Text(
                            'About Medwise',
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
                    alignment: const Alignment(-0.1, -0.4),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width*0.8,
                        height: MediaQuery.of(context).size.height*0.2,
                        child: const Text.rich(
                          TextSpan(
                            text: 'MedWise is a revolutionary smart medicine app and box device designed to manage medication schedules and monitor intake status of yourself and your loved ones. Simply connect the MedWise box with MedWise app, enter the medication routine, fill your MedWise and start!\n\n\n',
                            style: TextStyle(
                              color: Color(0xFF191717),
                              fontSize: 16,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        )
                    )
                ),
                Align(
                  alignment: const Alignment(0.0, 0.2),
                  child: SvgPicture.asset(
                    'asset/icons/pills.svg',
                    width: MediaQuery.of(context).size.width*0.19,
                    height:MediaQuery.of(context).size.height*0.18,
                  ),
                ),
                Align(
                  alignment: const Alignment(0.0, 0.64),
                  child: SvgPicture.asset(
                    'asset/icons/medwise_box.svg',
                    width: MediaQuery.of(context).size.width*0.4,
                    height:MediaQuery.of(context).size.height*0.172,
                  ),
                ),
                GoBackNextButtons(
                    onBackPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Welcome()),
                      );
                    },
                    onNextPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const About2()),
                      );
                    }
                )
              ]
          )
      ),
    );
  }
}


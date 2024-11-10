import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../buttons/buttons.dart';
import '../welcome_page.dart';
import '../about_medwise/about_medwise.dart';

class About3 extends StatelessWidget {
  const About3({super.key});

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
                            'MedWise Box',
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
                      child: const Text(
                        'Shell\n',
                        style: TextStyle(
                          color: Color(0xFF191717),
                          fontSize: 16,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    )
                ),
                Align(
                  alignment: const Alignment(0.45, -0.325),
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                            child: SvgPicture.asset(
                              'asset/icons/about_shell.svg',
                              width: MediaQuery.of(context).size.width*0.15,
                              height:MediaQuery.of(context).size.height*0.15,
                            )
                        ),

                        const SizedBox(
                          width: 7,
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.height * 0.20,
                          child: ListView.builder(
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              final items = [
                                {'title': 'Smart Lid:', 'content': 'Unlock only when “refill” button in the app is pressed.'},
                                {'title': 'Smart door:', 'content': 'Unlock only at set intake time.'},
                                {'title': 'Connect Button', 'content': ''},
                              ];

                              final item = items[index];

                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 3.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0.0, right: 8.0),
                                      child: Text(
                                        '${index + 1}.',
                                        style: const TextStyle(
                                          color: Color(0xFF191717),
                                          fontSize: 15,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '${item['title']} ',
                                              style: const TextStyle(
                                                color: Color(0xFF191717),
                                                fontSize: 15,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600,
                                                height: 0,
                                              ),
                                            ),
                                            TextSpan(
                                              text: item['content'],
                                              style: const TextStyle(
                                                color: Color(0xFF191717),
                                                fontSize: 15,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ]
                  ),
                ),
                Align(
                    alignment: const Alignment(-0.1, 0.3),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.8,
                      height: MediaQuery.of(context).size.height*0.2,
                      child: const Text(
                        'Carousel\n',
                        style: TextStyle(
                          color: Color(0xFF191717),
                          fontSize: 16,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    )
                ),
                Align(
                  alignment: const Alignment(0.0, 0.7),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                            child: SvgPicture.asset(
                              'asset/icons/about_carousel.svg',
                              width: MediaQuery.of(context).size.width*0.8,
                              height:MediaQuery.of(context).size.height*0.125,
                            )
                        ),

                        const SizedBox(
                          height: 5,
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          height: MediaQuery.of(context).size.height * 0.20,
                          child: ListView.builder(
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              final items = [
                                {'title': 'Compartments: ', 'content': 'Fill in all medication needed for the entire week.'},
                                {'title': 'Core:', 'content': 'Including a motor to revolve the carousel to the correct compartment every intake.'},
                              ];

                              final item = items[index];

                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 3.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0.0, right: 8.0),
                                      child: Text(
                                        '${index + 1}.',
                                        style: const TextStyle(
                                          color: Color(0xFF191717),
                                          fontSize: 15,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '${item['title']} ',
                                              style: const TextStyle(
                                                color: Color(0xFF191717),
                                                fontSize: 15,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600,
                                                height: 0,
                                              ),
                                            ),
                                            TextSpan(
                                              text: item['content'],
                                              style: const TextStyle(
                                                color: Color(0xFF191717),
                                                fontSize: 15,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ]
                  ),
                ),
                GoBackNextButtons(
                    onBackPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const About2()),
                      );
                    },
                    onNextPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Welcome()),
                      );
                    }
                )
              ]
          )
      ),
    );
  }
}
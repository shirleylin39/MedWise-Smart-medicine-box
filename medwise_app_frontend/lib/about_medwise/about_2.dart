import 'package:flutter/material.dart';
import '../buttons/buttons.dart';
import '../about_medwise/about_medwise.dart';


class About2 extends StatelessWidget {
  const About2({super.key});

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
                            'Features',
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
                  alignment: const Alignment(-0.1, 3.2),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: ListView(
                      children: [
                        for (var item in [
                          {'title': 'Material Safety:', 'content': 'Made of safe materials to ensure medication integrity.'},
                          {'title': 'Compact Design:', 'content': 'Enjoy the convenience of a small, light, and portable box.'},
                          {'title': 'Flexible Plans:', 'content': 'Personalised timetable for every users during the entire week, from 1 to 3 intakes a day.'},
                          {'title': 'Smart Reminders:', 'content': 'Receive timely alerts on both MedWise app and box.'},
                          {'title': 'Medication Tracking:', 'content': 'Keep track on the medication intake status of every users.'},
                          {'title': 'Medication Monitoring:', 'content': "Stay connected with loved ones' real-time medication status."},
                          {'title': 'Refill Reminders:', 'content': "Get notified when it's time to refill MedWise box."},
                          {'title': 'Secure Storage:', 'content': 'Auto-locked door and lid on the MedWise box to prevent wrongly intake.'},
                        ])
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 11.0, right: 8.0),
                                  child: Icon(Icons.brightness_1, size: 6, color: Color(0xFF191717)),
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
                          ),
                      ],
                    ),
                  ),
                ),
                GoBackNextButtons(
                    onBackPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const About1()),
                      );
                    },
                    onNextPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const About3()),
                      );
                    }
                )
              ]
          )
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../medwise_box/medwise_box.dart';
import 'buttons/buttons.dart';
import '../about_medwise/about_medwise.dart';
import '../connect_medwise/connect_medwise.dart';


class Welcome extends StatelessWidget {
  const Welcome({super.key});

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
              alignment: const Alignment(-0.4, -0.75),
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.7,
                height: MediaQuery.of(context).size.height*0.2,
                child: const Text(
                  'Welcome to MedWise',
                  style: TextStyle(
                    color: Color(0xFF191717),
                    fontSize: 40,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w800,
                    height: 0,
                    letterSpacing: -0.33,
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.0, -0.4),
              child: SvgPicture.asset(
                'asset/icons/pills.svg',
                width: MediaQuery.of(context).size.width*0.19,
                height:MediaQuery.of(context).size.height*0.18,
              ),
            ),
            Align(
              alignment: const Alignment(0.0, 0.04),
              child: SvgPicture.asset(
                'asset/icons/medwise_box.svg',
                width: MediaQuery.of(context).size.width*0.4,
                height:MediaQuery.of(context).size.height*0.172,
              ),
            ),
            Align(
              alignment: const Alignment(0.0, 0.55),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BigButton(
                    text: 'Connect to MedWise',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Connect1()),
                      );
                    }
                  ),
                  const SizedBox(height: 20),
                  BigButton(
                    text: 'About MedWise',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const About1()),

                      );
                    }
                  ),

                  const SizedBox(height: 20),
                  BigButton(
                      text: 'Box List',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BoxMain()),

                        );
                      }
                  ),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}





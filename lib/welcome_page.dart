import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'buttons.dart';
import 'about_medwise.dart';


class Main extends StatelessWidget {
  const Main({super.key});

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
              alignment: const Alignment(0.0, 0.45),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BigButton(
                    text: 'Connect to MedWise',
                    onPressed: () {
                      //To be added
                    },
                  ),
                  const SizedBox(height: 20),
                  BigButton(
                    text: 'About MedWise',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const About1()),
                      );
                    },
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





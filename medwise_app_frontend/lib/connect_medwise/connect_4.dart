import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../buttons/buttons.dart';
import '../medwise_box/medwise_box.dart';

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
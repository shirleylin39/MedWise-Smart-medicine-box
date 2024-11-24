import 'package:flutter/material.dart';
import '../buttons/buttons.dart';
import '../app_elements/app_elements.dart';
import '../medwise_box/medwise_box.dart';

class BoxDetails extends StatelessWidget {
  final Map<String, dynamic> device;

  const BoxDetails({
    super.key,
    required this.device,
  });

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
                device: device,
                onPressed:(){},
                isDisabled: true,
              ),
            ),
            Align(
              alignment: const Alignment (0.0, 0.5),
              child: BoxCalendar(
                deviceID: device['_id'],
                onDaySelected: (selectedDay) {
                },
              ),
            ),
            Align(
              alignment: const Alignment(0.75, -0.6),
              child:BoxSettingButton(
                onPressed: (){
                  Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) => BoxUpdate(device: device),
                  ),
                  );
                }
              )
            ),
            Align(
              alignment: const Alignment(0.75, 0.54),
              child:BoxSettingButton(
                onPressed: (){
                  Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) => BoxUpdatePlan(device: device),
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
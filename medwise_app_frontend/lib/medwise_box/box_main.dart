import 'package:flutter/material.dart';
import '../buttons/buttons.dart';
import '../welcome_page.dart';
import '../utils/api_service.dart';
import '../medwise_box/medwise_box.dart';
import '../notification/notification.dart';

class BoxMain extends StatefulWidget {
  const BoxMain({super.key});

  @override
  _BoxMainState createState() => _BoxMainState();
}
class _BoxMainState extends State<BoxMain> {
  List<dynamic> devices = [];

  @override
  void initState() {
    super.initState();
    getDevices();
  }

  Future<void> getDevices() async {
    // Use the service to fetch devices
    List<dynamic> currentDevices = await fetchDevices();
    setState(() {
      devices = currentDevices;
      devices.sort((a, b) => b['updatedAt'].compareTo(a['updatedAt']));
    });
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
              children:[
                Align(
                    alignment: const Alignment(0.0, -0.75),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width*0.7,
                        height: MediaQuery.of(context).size.height*0.2,
                        child: const Text(
                            'Current MedWise Boxes',
                            style: TextStyle(
                              color: Color(0xFF191717),
                              fontSize: 25,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w700,
                              height: 0,
                              letterSpacing: -0.33,
                            )
                        )
                    )
                ),
                Align(
                    alignment: const Alignment(0.0, 0.1),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.65,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: ListView.builder(
                        itemCount: devices.length,
                        itemBuilder: (context, index) {
                          final device = devices[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BoxInfoButton(
                              device: device,
                              onPressed: () {
                                if (device['is_paired'] == false) {
                                  boxPairNotification(context);
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BoxDetails(device: device),
                                    ),
                                  );
                                }
                              }
                            ),
                          );
                        },
                      ),
                    )
                ),
                Align(
                    alignment: const Alignment(-0.9, 0.9),
                    child:GoBackButton(
                        onPressed: (){
                          Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context) => const Welcome(),
                          ),
                          );
                        }
                    )
                )
              ]
          )
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: const Color(0xFFFFFFE9),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
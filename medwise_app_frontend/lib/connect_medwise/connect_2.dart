import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../buttons/buttons.dart';
import '../utils/providers.dart';
import '../connect_medwise/connect_medwise.dart';

class Connect2 extends StatefulWidget {
  const Connect2({super.key});

  @override
  _Connect2State createState() => _Connect2State();
}
class _Connect2State extends State<Connect2> {
  String boxMode = "";
  final TextEditingController _yourName = TextEditingController();
  final TextEditingController _otherName = TextEditingController();

  @override
  void initState() {
    super.initState();
    _yourName.addListener(() {
      setState(() {});
    });
    _otherName.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _yourName.dispose();
    _otherName.dispose();
    super.dispose();
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
                          {'instruction': 'Set up your MedWise'},
                        ];

                        final item = items[index];

                        return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, right: 15.0),
                                child: Text(
                                  '${index + 2}.',
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
                    alignment: const Alignment(0.0, 0.2),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width*0.8,
                        height: MediaQuery.of(context).size.height*0.6,
                        child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children:[
                              const Text(
                                'Your Name\n',
                                style: TextStyle(
                                  color: Color(0xFF191717),
                                  fontSize: 16,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.82,
                                height: MediaQuery.of(context).size.width * 0.12,
                                child: Stack(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.82,
                                        height: 45,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFFFFFE9),
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(width: 2, color: Color(0xFF191717)),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 10,
                                        top: 10,
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.6,
                                          height: 26,
                                          child: TextField(
                                            controller: _yourName,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your name',
                                              hintStyle: TextStyle(
                                                color: const Color(0xFF191717).withOpacity(0.5),
                                                fontSize: 16,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            style: const TextStyle(
                                              color: Color(0xFF191717),
                                              fontSize: 16,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                              const SizedBox(
                                  height: 20
                              ),
                              const Text(
                                'Select Mode\n',
                                style: TextStyle(
                                  color: Color(0xFF191717),
                                  fontSize: 16,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ModeButton(
                                    assetName: 'asset/icons/connect_selfmode.png',
                                    text: 'Self Carer',
                                    isSelected: boxMode == "self",
                                    onPressed: () {
                                      setState(() {
                                        boxMode = "self";
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 10),

                                  ModeButton(
                                      assetName: 'asset/icons/connect_othermode.png',
                                      text: 'Carer for others',
                                      isSelected: boxMode == "others",
                                      onPressed: () {
                                        setState(() {
                                          boxMode = "others";
                                        });
                                      }
                                  ),
                                ],
                              ),
                              const SizedBox(
                                  height: 20
                              ),
                              if (boxMode == "others") ...[
                                const Text(
                                  'Name of the person\n',
                                  style: TextStyle(
                                    color: Color(0xFF191717),
                                    fontSize: 16,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.82,
                                  height: MediaQuery.of(context).size.width * 0.12,
                                  child: Stack(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.82,
                                          height: 45,
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFFFFFFE9),
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(width: 2, color: Color(0xFF191717)),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 10,
                                          top: 10,
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            height: 26,
                                            child: TextField(
                                              controller: _otherName,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Enter the medicine intaker's name",
                                                hintStyle: TextStyle(
                                                  color: const Color(0xFF191717).withOpacity(0.5),
                                                  fontSize: 16,
                                                  fontFamily: 'Urbanist',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              style: const TextStyle(
                                                color: Color(0xFF191717),
                                                fontSize: 16,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                  ),
                                )
                              ]
                            ]
                        )
                    )
                ),
                Align(
                  alignment: const Alignment(-0.9, 0.9),
                  child: GoBackButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Connect1()),
                      );
                    },
                  ),
                ),
                Align(
                    alignment: const Alignment(0.9, 0.9),
                    child: (boxMode == "self" && _yourName.text.isNotEmpty) || (boxMode == "others" && _otherName.text.isNotEmpty && _yourName.text.isNotEmpty)
                        ? GoNextButton(
                      onPressed: () {
                        final provider = Provider.of<ConnectProvider>(context, listen: false);

                        if (boxMode == "self") {
                          provider.setTakerName(_yourName.text);
                          provider.setBoxMode("self");
                        } else if (boxMode == "others") {
                          provider.setTakerName(_otherName.text);
                          provider.setCarerName(_yourName.text);
                          provider.setBoxMode("others");
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Connect3()),
                        );
                      },
                    )
                        : Container()
                )
              ]
          )
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ConnectProvider extends ChangeNotifier {
  bool isPaired = false;
  String? serialNumber;
  String? takerName;
  String? boxMode;
  String? carerName;
  int? intakeTimes;

  void setPaired(bool paired) {
    isPaired = paired;
    notifyListeners();
  }

  void setSerialNumber(String? serial) {
    serialNumber = serial;
    notifyListeners();
  }

  void setTakerName(String name) {
    takerName = name;
    notifyListeners();
  }

  void setBoxMode(String mode) {
    boxMode = mode;
    notifyListeners();
  }

  void setCarerName(String name) {
    carerName = name;
    notifyListeners();
  }

  void setIntakeTimes(int times) {
    intakeTimes = times;
    notifyListeners();
  }

  void reset() {
    isPaired = false;
    serialNumber = null;
    takerName = null;
    boxMode = null;
    carerName = null;
    intakeTimes = null;
    notifyListeners();
  }

  Map<String, dynamic> getDeviceInfo() {
    return {
      'is_paired': isPaired,
      'serial_number': serialNumber,
      'taker_name': takerName,
      'box_mode': boxMode,
      'carer_name': carerName,
      'intake_times': intakeTimes,
    };
  }

  Future<void> submit(BuildContext context) async {
    final deviceInfo = getDeviceInfo();

    final url = Uri.parse('http://10.0.2.2:3000/devices');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(deviceInfo),
    );

    if (response.statusCode == 200) {
      print('Data sent successfully: ${response.body}');
      reset(); // Clear the data after successful submission
    } else {
      print('Failed to send data: ${response.statusCode}');
    }
  }
}

